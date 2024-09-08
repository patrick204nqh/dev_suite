# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Data::Transformations) do
  let(:dummy_class) { Class.new { extend DevSuite::Utils::Data::Transformations } }

  describe "#deep_symbolize_keys" do
    it "symbolizes keys in nested hashes" do
      data = { "a" => { "b" => 1, "c" => { "d" => 2 } } }
      result = dummy_class.deep_symbolize_keys(data)
      expect(result).to(eq({ a: { b: 1, c: { d: 2 } } }))
    end
  end

  describe "#deep_stringify_values" do
    it "converts all values to strings" do
      data = { a: { b: 1, c: { d: 2 } } }
      result = dummy_class.deep_stringify_values(data)
      expect(result).to(eq({ a: { b: "1", c: { d: "2" } } }))
    end
  end
end
