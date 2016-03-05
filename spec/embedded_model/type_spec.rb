require 'spec_helper'

RSpec.describe EmbeddedModel::Type do
  let(:type) do
    described_class.new { |attrs| OpenStruct.new(attrs) }
  end

  describe '#type_cast_from_database' do
    subject { type.type_cast_from_database(value) }

    context 'with JSON' do
      let(:value) { '{"foo":"bar"}' }

      it 'populates a model instance' do
        expect(subject.foo).to eq 'bar'
      end
    end

    context 'with nil' do
      let(:value) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '#type_cast_from_user' do
    subject { type.type_cast_from_user(value) }

    context 'with hash of attributes' do
      let(:value) { { 'foo' => 'bar' } }

      it 'populates a model instance' do
        expect(subject.foo).to eq 'bar'
      end
    end

    context 'with nil' do
      let(:value) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe '#type_cast_for_database' do
    subject { type.type_cast_for_database(value) }

    context 'with value' do
      let(:value) { { foo: 'bar' } }

      it 'serializes value using :as_json' do
        allow(value).to receive(:as_json).and_return({ foo: 'baz' })
        is_expected.to eq '{"foo":"baz"}'
      end
    end

    context 'with nil' do
      let(:value) { nil }
      it { is_expected.to be_nil }
    end
  end
end
