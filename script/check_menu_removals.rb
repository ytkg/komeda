# frozen_string_literal: true

require 'yaml'

base_path, updated_path = ARGV
abort 'Usage: ruby script/check_menu_removals.rb BASE UPDATED' unless base_path && updated_path

def menu_ids(path)
  YAML.safe_load_file(path, aliases: true).fetch('all').map { |item| item.fetch('id') }.uniq
end

base_ids = menu_ids(base_path)
updated_ids = menu_ids(updated_path)
abort 'The base menu has no IDs.' if base_ids.empty?

removed_ids = base_ids - updated_ids
puts "Removed #{removed_ids.length} of #{base_ids.length} menu IDs."
abort 'More than 15% of menu IDs were removed.' if removed_ids.length * 100 > base_ids.length * 15
