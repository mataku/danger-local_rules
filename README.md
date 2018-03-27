# danger-local_rules

A description of danger-local_rules.

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

    $ local_rules.check

## Development

1. Clone this repo
2. Run `bundle install` to setup dependencies.
3. Run `bundle exec rake spec` to run the tests.
4. Use `bundle exec guard` to automatically have tests run as you make changes.
5. Make your changes.
