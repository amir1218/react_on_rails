require "react_on_rails/utils"

module ReactOnRails
  module ReactComponent
    class Cache
      class << self
        def call(component_name, options)
          cache_key = cache_key(component_name, options)
          Rails.cache.fetch(cache_key) { yield }
        end

        private

        def cache_key(component_name, options)
          cache_keys = Array(options[:cache_key]).join("/")
          result = "react_on_rails/#{component_name}/#{cache_keys}}"
          result += "/#{ReactOnRails::Utils.bundle_hash}" if options[:prerender]
          result
        end
      end
    end
  end
end
