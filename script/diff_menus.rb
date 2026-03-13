# frozen_string_literal: true

require 'open3'
require 'yaml'

BASE_MENUS_PATH = 'HEAD:config/menus.yaml'
LOCAL_MENUS_PATH = 'config/menus.yaml'

def load_menus(content)
  YAML.safe_load(content, aliases: true, symbolize_names: true)
end

def index_by_id(menus)
  menus[:all].to_h { |item| [item[:id], item] }
end

def diff_menu_names(from_menus, to_menus)
  from = index_by_id(from_menus)
  to = index_by_id(to_menus)
  (to.keys - from.keys).map { |id| to[id][:name] }
end

def print_diff(title, items)
  return if items.empty?

  puts "### #{title}"
  items.each { |item| puts "- #{item}" }
end

def load_base_menus
  content, status = Open3.capture2('git', 'show', BASE_MENUS_PATH)
  raise "Failed to load #{BASE_MENUS_PATH}" unless status.success?

  load_menus(content)
end

def load_local_menus
  load_menus(File.read(LOCAL_MENUS_PATH))
end

base_menus = load_base_menus
local_menus = load_local_menus

added_items = diff_menu_names(base_menus, local_menus)
deleted_items = diff_menu_names(local_menus, base_menus)

puts 'This PR updates `config/menus.yaml`.'
puts
puts '## Menu diff'

if added_items.empty? && deleted_items.empty?
  puts 'No added or removed menu items were detected.'
else
  print_diff('Add', added_items)
  print_diff('Del', deleted_items)
end
