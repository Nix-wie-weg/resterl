require_relative '../../spec_helper'

require 'active_support/core_ext/object/try'

describe Resterl::BaseObject do
  context '#try from ActiveSupport' do
    subject { described_class.new(foo: :bar) }
    it 'returns a value if the key exists' do
      expect(subject.try(:foo)).to eq :bar
    end
    it 'returns nil if the key does not exist' do
      expect(subject.try(:fox)).not_to be
    end
  end
end
