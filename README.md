# RestoreBundledWith

[![Gem Version](http://img.shields.io/gem/v/restore_bundled_with.svg?style=flat)](http://badge.fury.io/rb/restore_bundled_with)
[![Build Status](http://img.shields.io/travis/packsaddle/ruby-restore_bundled_with/master.svg?style=flat)](https://travis-ci.org/packsaddle/ruby-restore_bundled_with)

Restore `BUNDLED WITH` section in `Gemfile.lock` from git repository.

```text
# Gemfile.lock
PATH
  remote: .
  specs:
(snip)

BUNDLED WITH
   1.10.4
```

## Description

Bundler `v1.10.0 or higher` tracks Bundler version in lockfile.
We should use latest Bundler, but sometimes we are afraid we have to use older Bundler.
We use Different version of Bundler between a project and a local machine.
In addition, Bundler `v1.9.x` removes `BUNDLED WITH` section.
*RestoreBundledWith* solves these conflicts.
*RestoreBundledWith* restores `BUNDLED WITH` section from git repository.

* [Track Bundler version in lockfile by smlance #3485 bundler/bundler](https://github.com/bundler/bundler/pull/3485)
* [Do not update BUNDLED WITH if no other changes to the lock happened #3697 bundler/bundler](https://github.com/bundler/bundler/issues/3697)

## Example

### Newer Bundler Case

```text
$ cat Gemfile.lock
(snip)
  unicorn-worker-killer
  webmock

BUNDLED WITH
   1.10.2
```

Execute `bundle update` by Bundler v1.10.3.

```
$ bundle update
(update)

$ git diff
(snip)
@@ -291,4 +296,4 @@ DEPENDENCIES
   webmock

 BUNDLED WITH
-   1.10.2
+   1.10.3
```

Then, execute `restore-bundled-with`.

```
$ restore-bundled-with
(restore BUNDLED WITH section)

$ git diff
(no diff)
```

There is no diff, because this restores `BUNDLED WITH` from git repository.

### Old Bundler (v1.9) Case

```text
$ cat Gemfile.lock
(snip)
  unicorn-worker-killer
  webmock

BUNDLED WITH
   1.10.2
```

Execute `bundle update` by Bundler v1.9.9.

```
$ bundle update
(update)

$ git diff
(snip)
@@ -289,6 +299,3 @@ DEPENDENCIES
   unicorn
   unicorn-worker-killer
   webmock
-
-BUNDLED WITH
-   1.10.2
```

Then, execute `restore-bundled-with`.

```
$ restore-bundled-with
(restore BUNDLED WITH section)

$ git diff
(no diff)
```

There is no diff, because this restores `BUNDLED WITH` from git repository.


## Usage

```text
Commands:
  restore-bundled-with delete          # Delete BUNDLED WITH section
  restore-bundled-with fetch           # Fetch BUNDLED WITH section
  restore-bundled-with help [COMMAND]  # Describe available commands or one specific command
  restore-bundled-with restore         # Restore BUNDLED WITH section in Gemfile.lock
  restore-bundled-with version         # Show the RestoreBundledWith version

Usage:
  restore-bundled-with restore

Options:
  [--data=DATA]
  [--file=FILE]
  [--lockfile=LOCKFILE]
                               # Default: Gemfile.lock
  [--ref=REF]
                               # Default: HEAD
  [--git-path=GIT_PATH]
                               # Default: .
  [--git-options=key:value]
  [--new-line=NEW_LINE]
                               # Default:
  [--debug], [--no-debug]
  [--verbose], [--no-verbose]

Restore BUNDLED WITH section in Gemfile.lock
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'restore_bundled_with'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install restore_bundled_with

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/packsaddle/ruby-restore_bundled_with. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

