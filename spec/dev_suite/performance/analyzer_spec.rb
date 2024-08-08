require 'spec_helper'
require 'dev_suite/performance/analyzer'

RSpec.describe DevSuite::Performance::Analyzer do
  describe '#analyze' do
    it 'generates a performance report' do
      analyzer = DevSuite::Performance::Analyzer.new(description: 'Test Block')

      expect {
        analyzer.analyze do
          sleep(0.1)
        end
      }.to output(/Performance Analysis/).to_stdout
    end

    it 'raises an error if no block is given' do
      analyzer = DevSuite::Performance::Analyzer.new(description: 'Test Block')

      expect { analyzer.analyze }.to raise_error(ArgumentError, 'No block given')
    end
  end
end
