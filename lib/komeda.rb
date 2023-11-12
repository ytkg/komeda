# frozen_string_literal: true

require 'yaml'
require 'hashie'
require 'active_support/all'
require_relative 'komeda/item'
require_relative 'komeda/version'

module Komeda
  class << self
    def method_missing(name, *args, &block)
      if (menu = menus[name])
        menu.map { |item| Komeda::Item[item.except(:id, :updated_at)] }
      else
        super(name, *args, &block)
      end
    end

    def respond_to_missing?(name, include_private)
      menus[name] ? true : super(name, include_private)
    end

    private

    def menus
      @menus ||= YAML.load_file('./config/menus.yaml', aliases: true, permitted_classes: [Time]).deep_symbolize_keys
    end
  end
end
