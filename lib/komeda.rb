# frozen_string_literal: true

require 'yaml'
require 'hashie'
require 'active_support/all'
require_relative 'komeda/item'
require_relative 'komeda/version'

module Komeda
  MENUS_FILE_PATH = './config/menus.yaml'

  menus = YAML.load_file(MENUS_FILE_PATH, aliases: true, permitted_classes: [Time]).deep_symbolize_keys

  menus.each_key do |key|
    define_singleton_method(key) do
      menus[key].map { |item| Komeda::Item[item.except(:id, :updated_at)] }
    end
  end
end
