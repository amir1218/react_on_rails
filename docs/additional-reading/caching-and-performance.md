# Caching and Performance


## Caching

### Fragment Caching

If you wish to do fragment caching that includes React on Rails rendered components, be sure to
include the bundle name of your server rendering bundle in your cache key. This is analogous to
how Rails puts an MD5 hash of your views in the cache key so that if the views change, then your
cache is busted. In the case of React code, if your React code changes, then your bundle name will
change due to the typical inclusion of a hash in the name.

Even if you are not using server rendering, you need to configure:

1. config value
2. bundle for this config value with all JS for components to cache

#### Using the cache_key parameter in react_component or react_component_hash

```ruby
react_component("App", cache_key: "cache-key", prerender: true) do
  props
end
```

#### If you wish to do this manually

```ruby
# Returns the hashed file name of the server bundle when using webpacker.
# Necessary fragment-caching keys.
<% cache_key = [ReactOnRails::Utils.bundle_hash, @some_active_record] %>
<% cache cache_key do %>
  <%= react_component("App", props: props)
<% end %>
```

### HTTP Caching with Webpacker

When creating a HTTP cache, you want the cache key to include the client bundle file
name which includes the hash from webpacker.

The hash is configured in your webpack config file or done automatically by your
webpacker configuration.

```javascript
  output: {
    filename: isHMR ? '[name]-[hash].js' : '[name]-[chunkhash].js',
```

See [webpack.client.rails.build.config.js](../spec/dummy/client/webpack.client.rails.build.config.js)
for a full example of setting the hash in the output filename.

Call this method to get the client bundle file name. Note, you have to pass which bundle name.

```ruby
# Returns the hashed file name when using webpacker. Useful for creating cache keys.
ReactOnRails::Utils.bundle_file_name(bundle_name)
```
