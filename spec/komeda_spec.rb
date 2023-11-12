# frozen_string_literal: true

RSpec.describe Komeda do
  it 'has a version number' do
    expect(Komeda::VERSION).not_to be nil
  end

  it 'can fetch all menu' do
    expect(Komeda.all).not_to be nil
  end
end
