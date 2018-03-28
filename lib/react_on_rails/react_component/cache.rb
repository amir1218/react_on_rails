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
          keys = [
            "react_on_rails",
            component_name,
            options[:cache_key]
          ]
          keys.push(ReactOnRails::Utils.bundle_hash) if options[:prerender]

          ActiveSupport::Cache.expand_cache_key(keys)
        end
      end
    end
  end
end
