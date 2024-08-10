require 'spec_helper'

RSpec.describe DevSuite::Performance::Analyzer do
  describe '.analyze' do
    subject { described_class }

    it 'generates a performance report' do
      expect {
        subject.analyze(description: 'Test Block') do
          sleep(0.1)
        end
      }.to output(/Performance Analysis/).to_stdout
    end

    it 'raises an error if no block is given' do
      expect { subject.analyze(description: 'Test Block') }.to raise_error(ArgumentError, 'No block given')
    end
  end
end
