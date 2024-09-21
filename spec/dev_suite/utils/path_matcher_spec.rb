# frozen_string_literal: true

require "spec_helper"

RSpec.describe(DevSuite::Utils::PathMatcher) do
  describe ".match?" do
    let(:txt_file) { "spec/fixtures/test.txt" }
    let(:rb_file) { "spec/fixtures/test.rb" }
    let(:root_txt_file) { "test.txt" }

    context "with includes only" do
      context 'when using "*.txt"' do
        let(:includes) { ["*.txt"] }

        it "matches files in any directory" do
          expect(described_class.match?(txt_file, includes: includes)).to(be_truthy)
        end

        it "matches files in the root directory" do
          expect(described_class.match?(root_txt_file, includes: includes)).to(be_truthy)
        end

        it "does not match files with a different extension" do
          expect(described_class.match?(rb_file, includes: includes)).to(be_falsey)
        end
      end

      context 'when using "**/*"' do
        let(:includes) { ["**/*"] }

        it "matches any file" do
          expect(described_class.match?(txt_file, includes: includes)).to(be_truthy)
          expect(described_class.match?(rb_file, includes: includes)).to(be_truthy)
        end
      end

      context 'when using "**/*.txt"' do
        let(:includes) { ["**/*.txt"] }

        it "matches files using the pattern" do
          expect(described_class.match?(txt_file, includes: includes)).to(be_truthy)
        end
      end
    end

    context "with excludes only" do
      context 'when using "*.txt"' do
        let(:excludes) { ["*.txt"] }

        it "does not match files excluded by the pattern" do
          expect(described_class.match?(txt_file, excludes: excludes)).to(be_falsey)
        end

        it "matches files not excluded" do
          expect(described_class.match?(rb_file, excludes: excludes)).to(be_truthy)
        end
      end
    end

    context "with both includes and excludes" do
      let(:includes) { ["**/*.txt"] }

      context "when the file matches both include and exclude patterns" do
        let(:excludes) { ["*.txt"] }

        it "excludes the file even if it matches the include pattern" do
          expect(described_class.match?(txt_file, includes: includes, excludes: excludes)).to(be_falsey)
        end
      end

      context "when the file matches include patterns but not exclude patterns" do
        let(:excludes) { ["test.rb"] }

        it "matches the file as it is included and not excluded" do
          expect(described_class.match?(txt_file, includes: includes, excludes: excludes)).to(be_truthy)
        end
      end
    end
  end
end
