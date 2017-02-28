require 'spec_helper'

describe OsxWifi do
  it 'has a version number' do
    expect(OsxWifi::VERSION).not_to be nil
  end

  it '#calculate_bars' do
    signal = OsxWifi::Signal.new(unicode_output: false)
    expect(signal.bars).to be
    expect(signal.bars).to be >= 0
    expect(signal.bars).to be <= 4
  end

  it '#unicode_bars' do
    signal = OsxWifi::Signal.new(unicode_output: true)
    expect(signal.bars).to be
  end
end
