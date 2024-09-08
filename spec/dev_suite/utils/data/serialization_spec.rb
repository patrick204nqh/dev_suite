# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Data::Serialization) do
  let(:dummy_class) { Class.new { extend DevSuite::Utils::Data::Serialization } }

  describe "#to_json" do
    it "converts a hash to JSON" do
      data = { name: "Alice", age: 30 }
      result = dummy_class.to_json(data)
      expect(result).to(eq('{"name":"Alice","age":30}'))
    end
  end

  describe "#to_csv" do
    it "converts an array of hashes to CSV" do
      data = [{ name: "Alice", age: 30 }, { name: "Bob", age: 25 }]
      result = dummy_class.to_csv(data)
      expect(result).to(eq("name,age\nAlice,30\nBob,25\n"))
    end
  end
end
