# frozen_string_literal: true

RSpec.describe Komeda do
  it 'has a version number' do
    expect(Komeda::VERSION).not_to be nil
  end

  it 'can fetch all menu' do
    expect(Komeda.all).not_to be nil
  end

  it 'does not leak destructive changes across calls' do
    item = Komeda.drinks.first
    item_id = item[:id]
    original_name = item[:name].dup

    item[:name] << 'X'

    expect(Komeda.drinks.find { |menu| menu[:id] == item_id }[:name]).to eq(original_name)
    expect(Komeda.all.find { |menu| menu[:id] == item_id }[:name]).to eq(original_name)
  end
end
