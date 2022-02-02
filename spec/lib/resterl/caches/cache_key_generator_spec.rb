require 'spec_helper'

describe Resterl::Caches::CacheKeyGenerator do
  it 'generates a stable digest for the same url' do
    a = described_class.generate('http://example.com', {}, {})
    b = described_class.generate('http://example.com', {}, {})

    expect(a).to eq b
  end

  it 'generates a stable digest with the same parameters' do
    a = described_class
      .generate('http://example.com', { 'foo' => 'bar' }, {})
    b = described_class
      .generate('http://example.com', { 'foo' => 'bar' }, {})

    expect(a).to eq b
  end

  it 'generates a stable digest with the same headers' do
    a = described_class
      .generate('http://example.com', {}, 'x-test' => '0.5')
    b = described_class
      .generate('http://example.com', {}, 'x-test' => '0.5')

    expect(a).to eq b
  end

  it 'generates a stable digest with same url, params and headers' do
    a = described_class
      .generate('http://example.com', { 'xy' => 'xxx' }, 'x-test' => '0.5')
    b = described_class
      .generate('http://example.com', { 'xy' => 'xxx' }, 'x-test' => '0.5')

    expect(a).to eq b
  end

  it 'generates different digest for different urls' do
    a = described_class.generate('http://example.net', {}, {})
    b = described_class.generate('http://example.com', {}, {})

    expect(a).not_to eq b
  end

  it 'generates different digest with different parameters' do
    a = described_class.generate('http://example.com', { 'blib' => 'blub' }, {})
    b = described_class.generate('http://example.com', { 'blib' => 'oopf' }, {})
    c = described_class.generate('http://example.com', { 'oopf' => 'blip' }, {})

    expect([a, b, c].uniq.length).to eq 3
  end

  it 'generates different digest with different headers' do
    a = described_class
      .generate('http://example.com', {}, 'accept' => 'json')
    b = described_class
      .generate('http://example.com', {}, 'accept' => '*/*')

    expect(a).not_to eq b
  end

  it 'generates the same digest with url parameters and headers ' \
    'in diffrent order' do
    a = described_class.generate(
      'http://example.com',
      { 'a' => 'aaa', 'b' => 'bbb' },
      'x-aaa' => 'aaa', 'x-bbb' => 'bbb'
    )
    b = described_class .generate(
      'http://example.com',
      { 'b' => 'bbb', 'a' => 'aaa' },
      'x-bbb' => 'bbb', 'x-aaa' => 'aaa'
    )

    expect(a).to eq b
  end
end
