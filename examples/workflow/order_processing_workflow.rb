# frozen_string_literal: true

require_relative "../helpers"

$LOAD_PATH.unshift(File.expand_path("../../lib", __dir__))
require "dev_suite"

# Constants
BASE_URL = "https://ecommerce.example.com"
NUMBER_OF_USERS = 500
CHUNK_SIZE = 50
DEFAULT_PASSWORD = "password123"
STORE_PATH = "tmp/order_store.json"

# Headers for HTTP requests
REQUEST_HEADERS = {
  "accept" => "*/*",
  "content-type" => "application/x-www-form-urlencoded",
  "user-agent" => "Mozilla/5.0",
}

# Helper Functions
def register_user(username, phone, password)
  endpoint = "#{BASE_URL}/api/v1/register"
  body_data = { "username" => username, "phone" => phone, "password" => password }
  APIHelper.make_post_request(endpoint: endpoint, body_data: body_data, success_criteria: ->(response) {
    response["status"] == "success"
  })
end

def login_user(username, password)
  endpoint = "#{BASE_URL}/api/v1/login"
  body_data = { "username" => username, "password" => password }
  APIHelper.make_post_request(endpoint: endpoint, body_data: body_data, success_criteria: ->(response) {
    response["token"].present?
  })
end

def fetch_order(token, user_id)
  endpoint = "#{BASE_URL}/api/v1/orders"
  body_data = { "token" => token, "user_id" => user_id }
  APIHelper.make_post_request(endpoint: endpoint, body_data: body_data, success_criteria: ->(response) {
    response["order_id"].present?
  })
end

def process_payment(order_id, token, user_id)
  endpoint = "#{BASE_URL}/api/v1/pay"
  body_data = { "order_id" => order_id, "token" => token, "user_id" => user_id }
  APIHelper.make_post_request(endpoint: endpoint, body_data: body_data, success_criteria: ->(response) {
    response["status"] == "success"
  })
end

# Workflow Steps
register_step = DevSuite::Workflow.create_step("Register Users") do |ctx|
  users = []
  password = ctx.get(:password)

  # Generate fake users using Faker
  user_tasks = Array.new(NUMBER_OF_USERS) do
    {
      username: DataHelper.generate_human_username,
      phone: DataHelper.generate_phone_number,
      password: password,
    }
  end

  user_chunks = user_tasks.each_slice(CHUNK_SIZE).to_a

  user_chunks.each do |chunk|
    parallel_step = DevSuite::Workflow.create_parallel_step("Parallel Registration") do |ctx|
      chunk.map do |user_data|
        ->(ctx) {
          username = user_data[:username]
          phone = user_data[:phone]
          password = user_data[:password]

          puts "Registering user #{username}..."
          response = register_user(username, phone, password)

          if response[:success]
            puts "User #{username} registered successfully!"
            users << user_data
          else
            puts "Failed to register #{username}: #{response&.dig(:response, "error") || "Unknown error"}"
          end
        }
      end
    end
    parallel_step.run(ctx)
  end

  ctx.set(:users, users)
  ctx.data
end

save_users_step = DevSuite::Workflow.create_conditional_step("Save Users to Store", ->(ctx) {
  ctx.get(:users)&.any?
}) do |ctx|
  ctx.store.set(:users, ctx.get(:users))
  puts "Saved #{ctx.get(:users).size} users to the store."
  ctx.data
end

login_step = DevSuite::Workflow.create_conditional_step("Login Users", ->(ctx) {
  ctx.get(:username) && ctx.get(:password)
}) do |ctx|
  response = login_user(ctx.get(:username), ctx.get(:password))

  if response[:success]
    ctx.set(:token, response[:response]["token"])
    ctx.set(:user_id, response[:response]["user_id"])
    puts "User #{ctx.get(:username)} logged in successfully!"
  else
    puts "Failed to log in user #{ctx.get(:username)}."
  end

  ctx.data
end

fetch_order_step = DevSuite::Workflow.create_conditional_step("Fetch Orders", ->(ctx) {
  ctx.get(:token) && ctx.get(:user_id)
}) do |ctx|
  response = fetch_order(ctx.get(:token), ctx.get(:user_id))

  if response[:success]
    ctx.set(:order_id, response[:response]["order_id"])
    puts "Order fetched for user #{ctx.get(:username)}: Order ID #{response[:response]["order_id"]}"
  else
    puts "Failed to fetch order for user #{ctx.get(:username)}."
  end

  ctx.data
end

process_payment_step = DevSuite::Workflow.create_conditional_step("Process Payment", ->(ctx) {
  ctx.get(:order_id) && ctx.get(:token) && ctx.get(:user_id)
}) do |ctx|
  response = process_payment(ctx.get(:order_id), ctx.get(:token), ctx.get(:user_id))

  if response[:success]
    puts "Payment processed for order #{ctx.get(:order_id)}."
  else
    puts "Failed to process payment for order #{ctx.get(:order_id)}."
  end

  ctx.data
end

# Main Workflow Execution
workflow = DevSuite::Workflow.create_engine(
  { password: DEFAULT_PASSWORD },
  driver: :file,
  path: STORE_PATH,
)

workflow.step(register_step)
  .step(save_users_step)
  .step(login_step)
  .step(fetch_order_step)
  .step(process_payment_step)
  .execute
