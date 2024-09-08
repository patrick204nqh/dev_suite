# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Data::SearchFilter) do
  let(:dummy_class) { Class.new { extend DevSuite::Utils::Data::SearchFilter } }

  describe "#deep_find_by_key" do
    it "finds all values by a given key" do
      data = { a: { b: 1, c: { b: 2 } }, d: { b: 3 } }
      result = dummy_class.deep_find_by_key(data, :b)
      expect(result).to(contain_exactly(1, 2, 3))
    end
  end

  describe "#deep_filter_by_key_value" do
    it "filters nested data by key-value pair" do
      data = { a: { b: 1, c: 2 }, d: { b: 1, e: 3 } }
      result = dummy_class.deep_filter_by_key_value(data, :b, 1)
      expect(result).to(eq({ a: { b: 1, c: 2 }, d: { b: 1, e: 3 } }))
    end
  end
end
