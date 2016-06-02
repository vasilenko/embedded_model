require 'spec_helper'

RSpec.describe EmbeddedModel::Type do
  let(:type) do
    described_class.new { |attrs| OpenStruct.new(attrs) }
  end

  describe '#cast' do
    subject { type.cast(value) }

    let(:value) { { 'foo' => 'bar' } }

    it 'populates a model instance' do
      expect(subject.foo).to eq 'bar'
    end
  end

  describe '#serialize' do
    subject { type.serialize(value) }

    let(:value) { { foo: 'bar' } }

    it 'serializes value using :as_json' do
      allow(value).to receive(:as_json).and_return({ foo: 'baz' })
      is_expected.to eq '{"foo":"baz"}'
    end
  end

  describe '#deserialize' do
    subject { type.deserialize(value) }

    let(:value) { '{"foo":"bar"}' }

    it 'populates a model instance' do
      expect(subject.foo).to eq 'bar'
    end
  end
end
