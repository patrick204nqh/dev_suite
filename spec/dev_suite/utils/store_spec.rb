# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Store) do
  subject { described_class.store }

  context "when the store is memory-based" do
    describe "#store" do
      it "stores a value by key" do
        subject.store("key1", "value1")
        expect(subject.fetch("key1")).to(eq("value1"))
      end
    end

    describe "#fetch" do
      it "fetches a value by key" do
        subject.store("key1", "value1")
        expect(subject.fetch("key1")).to(eq("value1"))
      end

      it "returns nil for a non-existent key" do
        expect(subject.fetch("non_existent_key")).to(be_nil)
      end
    end

    describe "#delete" do
      it "deletes a value by key" do
        subject.store("key1", "value1")
        subject.delete("key1")
        expect(subject.fetch("key1")).to(be_nil)
      end
    end

    describe "#clear" do
      it "clears all stored data" do
        subject.store("key1", "value1")
        subject.clear
        expect(subject.fetch("key1")).to(be_nil)
      end
    end
  end
end
