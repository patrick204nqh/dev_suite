# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Data::PathAccess) do
  let(:dummy_class) { Class.new { extend DevSuite::Utils::Data::PathAccess } }

  describe "#get_value_by_path" do
    it "retrieves a value using dot notation" do
      data = { users: [{ name: "Alice" }, { name: "Bob" }] }
      result = dummy_class.get_value_by_path(data, "users[1].name")
      expect(result).to(eq("Bob"))
    end

    it "retrieves a value using array path notation" do
      data = { users: [{ name: "Alice" }, { name: "Bob" }] }
      result = dummy_class.get_value_by_path(data, [:users, 1, :name])
      expect(result).to(eq("Bob"))
    end
  end

  describe "#set_value_by_path" do
    it "sets a value using dot notation" do
      data = { users: [{ name: "Alice" }, { name: "Bob" }] }
      dummy_class.set_value_by_path(data, "users[1].name", "Charlie")
      expect(data[:users][1][:name]).to(eq("Charlie"))
    end

    it "sets a value using array path notation" do
      data = { users: [{ name: "Alice" }, { name: "Bob" }] }
      dummy_class.set_value_by_path(data, [:users, 1, :name], "Charlie")
      expect(data[:users][1][:name]).to(eq("Charlie"))
    end
  end

  describe "#delete_key_by_path" do
    it "deletes a key using dot notation" do
      data = { users: [{ name: "Alice" }, { name: "Bob" }] }
      dummy_class.delete_key_by_path(data, "users[1].name")
      expect(data[:users][1]).to(eq({}))
    end

    it "deletes a key using array path notation" do
      data = { users: [{ name: "Alice" }, { name: "Bob" }] }
      dummy_class.delete_key_by_path(data, [:users, 1, :name])
      expect(data[:users][1]).to(eq({}))
    end
  end
end
