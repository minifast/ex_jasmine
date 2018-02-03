# Jasmine

This package is a minimum viable spike toward adding Jasmine test runner to a
Phoenix application.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `ex_jasmine` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_jasmine, "~> 0.2.1"}]
    end
    ```

  2. Ensure `ex_jasmine` is started before your application:

    ```elixir
    def application do
      [applications: [:ex_jasmine]]
    end
    ```

## Configuration

You'll need to add the following sections to `assets/brunch-config.js`:

```javascript
exports.config = {
  files: {
    javascripts: {
      joinTo: {'js/test.js': [/^spec/, /^js/, /^node_modules/]}
    },
    stylesheets: {
      joinTo: {'css/test.css': 'css/test.scss'}
    }
  },

  paths: {
    watched: ['static', 'css', 'js', 'vendor', 'spec']
  },

  plugins: {
    sass: {joptions: {includePaths: ['node_modules/jasmine-core/lib']}}
  },

  modules: {autoRequire: {'js/test.js': ['spec/spec_helper']}}
}

```

Jasmine assumes a `spec/**/*_spec.js` convention for file names.
You'll also need to add the following code into `assets/spec/spec_helper.js`:

```javascript
import jasmineRequire from 'jasmine-core/lib/jasmine-core/jasmine'
global.jasmineRequire = jasmineRequire
require('jasmine-core/lib/jasmine-core/jasmine-html')
require('jasmine-core/lib/jasmine-core/boot')

window.require.list().forEach(function (module) {
  if (module.indexOf("_spec.js") !== -1) require(module)
})
```

Finally, to style the Jasmine path, add the following to `assets/css/test.scss`:

```scss
@import "jasmine-core/jasmine";
```
