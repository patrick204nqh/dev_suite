require 'spec_helper'

RSpec.describe DevSuite::Utils::FileLoader do
  describe '.load' do
    context 'when the file is a JSON file' do
      let(:path) { 'spec/fixtures/files/test.json' }

      it 'loads the file' do
        expect(described_class.load(path)).to eq({ 'key' => 'value' })
      end
    end
  end
end