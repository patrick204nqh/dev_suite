# frozen_string_literal: true

module DataHelper
  require "faker"

  class << self
    # Generate a human-readable username with a random number inserted
    def generate_human_username
      base_username = Faker::Internet.username(specifier: 8..12)
      random_number = rand(100..999)
      random_position = rand(0..base_username.length)
      base_username.insert(random_position, random_number.to_s)
    end

    # Generate a random phone number (can specify format: :national, :international, :mobile)
    def generate_phone_number(format: :national)
      case format
      when :national
        Faker::PhoneNumber.phone_number
      when :international
        Faker::PhoneNumber.cell_phone_in_e164
      when :mobile
        Faker::PhoneNumber.cell_phone
      else
        Faker::PhoneNumber.phone_number
      end
    end

    # Generate a random email address (can specify domain)
    def generate_email(username = nil, domain = "example.com")
      username ||= Faker::Internet.username(specifier: 8..12)
      "#{username}@#{domain}"
    end

    # Generate a secure random password
    def generate_secure_password(length: 12)
      Faker::Internet.password(min_length: length, mix_case: true, special_characters: true)
    end

    # Generate a random full name (first and last)
    def generate_full_name
      "#{Faker::Name.first_name} #{Faker::Name.last_name}"
    end

    # Generate a random address
    def generate_address
      "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.zip}"
    end

    # Generate a random date of birth (for users between min_age and max_age)
    def generate_date_of_birth(min_age: 18, max_age: 65)
      Faker::Date.birthday(min_age: min_age, max_age: max_age)
    end

    # Generate a random company name
    def generate_company_name
      Faker::Company.name
    end

    # Generate a random IPv4 or IPv6 address
    def generate_ip_address(version: :v4)
      case version
      when :v4
        Faker::Internet.ip_v4_address
      when :v6
        Faker::Internet.ip_v6_address
      else
        Faker::Internet.ip_v4_address
      end
    end
  end
end
