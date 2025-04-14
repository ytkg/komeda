# frozen_string_literal: true

require 'open-uri'
require 'json'
require 'yaml'
require 'active_support/all'
require_relative '../lib/komeda'

class DataUpdater
  API_ENDPOINT = 'https://eu.komeda.co.jp/v1/hp/menu'
  LARGE_TYPES_MAP = {
    '1-2' => 'drinks',
    '1-3' => 'desserts',
    '1-4' => 'foods'
  }.freeze

  class << self
    def run
      data = fetch_data
      menus = generate_menu_data(data)

      File.write(Komeda::MENUS_FILE_PATH, menus.to_yaml)
    end

    private

    def fetch_data
      response = URI.parse(API_ENDPOINT).open
      JSON.parse(response.read)['menus']
    end

    def generate_menu_data(data)
      initial_hash = Hash.new { |h, k| h[k] = [] }
      data.sort_by { _1['id'] }.each_with_object(initial_hash) do |row, hash|
        category_name = LARGE_TYPES_MAP[row['large_type']]

        next if category_name.nil?

        item = row.slice('id', 'name', 'description', 'photo_url')

        hash['all'].push(item)
        hash[category_name].push(item)
      end
    end
  end
end

DataUpdater.run
