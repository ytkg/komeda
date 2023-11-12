# frozen_string_literal: true

module Komeda
  class Item < Hash
    include Hashie::Extensions::MethodAccess
  end
end
