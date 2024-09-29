# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Data::PathAccess) do
  let(:dummy_class) { Class.new { extend DevSuite::Utils::Data::PathAccess } }

  describe "#get_value_by_path" do
    context "with valid paths" do
      let(:data) { { users: [{ name: "Alice" }, { name: "Bob" }] } }

      it "retrieves a value using dot notation" do
        result = dummy_class.get_value_by_path(data, "users[1].name")
        expect(result).to(eq("Bob"))
      end

      it "retrieves a value using array path notation" do
        result = dummy_class.get_value_by_path(data, [:users, 1, :name])
        expect(result).to(eq("Bob"))
      end

      it "retrieves a value using symbol keys with dots" do
        result = dummy_class.get_value_by_path(data, :"users.1.name")
        expect(result).to(eq("Bob"))
      end
    end

    context "with invalid paths" do
      let(:data) { { users: [{ name: "Alice" }, { name: "Bob" }] } }

      it "raises an error when the path is not found" do
        expect do
          dummy_class.get_value_by_path(
            data,
            "users[2].name",
          )
        end.to(raise_error(DevSuite::Utils::Data::PathAccess::InvalidPathError))
      end

      it "returns nil for non-existent nested keys" do
        result = dummy_class.get_value_by_path(data, "users[0].age")
        expect(result).to(be_nil)
      end
    end
  end

  describe "#set_value_by_path" do
    let(:data) { { users: [{ name: "Alice" }, { name: "Bob" }] } }

    context "with valid paths" do
      it "sets a value using dot notation" do
        dummy_class.set_value_by_path(data, "users[1].name", "Charlie")
        expect(data[:users][1][:name]).to(eq("Charlie"))
      end

      it "sets a value using array path notation" do
        dummy_class.set_value_by_path(data, [:users, 1, :name], "Charlie")
        expect(data[:users][1][:name]).to(eq("Charlie"))
      end

      it "creates new nested keys if they don't exist" do
        dummy_class.set_value_by_path(data, "users[0].age", 30)
        expect(data[:users][0][:age]).to(eq(30))
      end
    end

    context "with invalid paths" do
      it "creates new nested keys if they don't exist" do
        dummy_class.set_value_by_path(data, "users[2].age", 30)
        expect(data[:users][2][:age]).to(eq(30))
      end
    end
  end

  describe "#delete_key_by_path" do
    let(:data) { { users: [{ name: "Alice" }, { name: "Bob" }] } }

    context "with valid paths" do
      it "deletes a key using dot notation" do
        dummy_class.delete_key_by_path(data, "users[1].name")
        expect(data[:users][1]).to(eq({}))
      end

      it "deletes a key using array path notation" do
        dummy_class.delete_key_by_path(data, [:users, 1, :name])
        expect(data[:users][1]).to(eq({}))
      end
    end

    context "with invalid paths" do
      it "raises an error when trying to delete a non-existent key" do
        expect do
          dummy_class.delete_key_by_path(
            data,
            "users[2].name",
          )
        end.to(raise_error(DevSuite::Utils::Data::PathAccess::DataStructureError))
      end
    end
  end

  # Shared examples for common behaviors
  shared_examples "path manipulation with different notations" do |method, path, expected_result|
    it "works with dot notation" do
      dummy_class.send(method, data, path[:dot])
      expect(data).to(eq(expected_result))
    end

    it "works with array path notation" do
      dummy_class.send(method, data, path[:array])
      expect(data).to(eq(expected_result))
    end
  end

  context "shared examples for various path manipulations" do
    let(:data) { { users: [{ name: "Alice" }, { name: "Bob" }] } }

    include_examples "path manipulation with different notations",
      :delete_key_by_path,
      { dot: "users[1].name", array: [:users, 1, :name] },
      { users: [{ name: "Alice" }, {}] }
  end
end
