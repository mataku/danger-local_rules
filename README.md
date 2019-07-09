# danger-local_rules

A [Danger](http://danger.systems) plugin to manage local rules.

## Installation

    $ gem install danger-local_rules

## Usage
Create `.danger_local_rules.yml` in project root, and add contents to fail or warn.

```yml
# See: example/.danger_local_rules.yml
failure:
  'legacyFunc': ':cry:'
warning:
  'TODO': 'You should check'
  'FIXME': 'Yet?'
```

Add this to Dangerfile.

```ruby

# Optional: you can specify yml file path. (Default: $projectRoot/.danger_local_rules)
# local_rules.rules_file = './scripts/file.yml'
local_rules.check
```


## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
