require_relative '../../spec_helper'
require 'active_support/core_ext/object/try'

describe Resterl::BaseObject do
  subject { described_class.new(foo: :bar) }

  context '#try from ActiveSupport' do
    it 'returns a value if the key exists' do
      expect(subject.try(:foo)).to eq :bar
    end
    it 'returns nil if the key does not exist' do
      expect(subject.try(:fox)).not_to be
    end
  end

  it { is_expected.to respond_to(:response) }
  it { is_expected.to respond_to(:foo) }
  it { is_expected.not_to respond_to(:fox) }

  it 'supports respond_to with private methods' do
    expect(subject.respond_to?(:log_built_in_message, true)).to be_truthy
  end
end
