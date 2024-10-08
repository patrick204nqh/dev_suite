# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::Store) do
  subject { described_class.instance }

  shared_examples "a store" do
    describe "#set" do
      it "stores a value by key" do
        subject.set("key1", "value1")
        expect(subject.fetch("key1")).to(eq("value1"))
      end
    end

    describe "#fetch" do
      it "fetches a value by key" do
        subject.set("key1", "value1")
        expect(subject.fetch("key1")).to(eq("value1"))
      end

      it "returns nil for a non-existent key" do
        expect(subject.fetch("non_existent_key")).to(be_nil)
      end
    end

    describe "#delete" do
      it "deletes a value by key" do
        subject.set("key1", "value1")
        subject.delete("key1")
        expect(subject.fetch("key1")).to(be_nil)
      end
    end

    describe "#clear" do
      it "clears all stored data" do
        subject.set("key1", "value1")
        subject.clear
        expect(subject.fetch("key1")).to(be_nil)
      end
    end
  end

  context "when the store is memory-based" do
    it_behaves_like "a store"
  end

  context "when the store is file-based" do
    let(:store_path) { DevSuite::Utils::Store::Config.configuration.settings.get("driver.file.path") }

    before do
      FileUtils.rm_rf(store_path)

      DevSuite::Utils::Store::Config.configure do |config|
        config.driver = :file
      end
    end

    after do
      FileUtils.rm_rf(store_path)
    end

    it_behaves_like "a store"

    describe "#store" do
      # Temporary test to ensure the file is created
      xit "creates a file to store the data" do
        subject.set("key1", "value1")
        expect(File.exist?(store_path)).to(be(true))
      end
    end
  end
end
