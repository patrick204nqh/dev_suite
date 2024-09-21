# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Data::BaseOperations) do
  let(:dummy_class) { Class.new { extend DevSuite::Utils::Data::BaseOperations } }

  describe "#deep_delete_key" do
    it "removes a key at any level in the hash" do
      data = { a: 1, b: { c: 2, d: { e: 3 } } }
      result = dummy_class.deep_delete_key(data, :d)
      expect(result).to(eq({ a: 1, b: { c: 2 } }))
    end
  end

  describe "#deep_merge" do
    it "merges two hashes deeply" do
      hash1 = { a: { b: 1 }, c: 2 }
      hash2 = { a: { d: 3 }, c: 4 }
      result = dummy_class.deep_merge(hash1, hash2)
      expect(result).to(eq({ a: { b: 1, d: 3 }, c: 4 }))
    end
  end
end
