# Chaptan

Chaptan is a command line tool that adds chapters to your MP3 files as IDv3, currently by YAML.

## Installation

Install it as:

    $ gem install chaptan

## Usage

Prepare a YAML file, for example, in `your-chapters-file.yml` with the following content.

```yaml
- title: Introduction
  start: 0
- title: 聖闘士星矢
  start: 1
- title: FGOについて
  start: 2
```

The attribute `start` means the number of seconds from the beginning of the MP3 file. And then, do like this to add chapters to `your-audio-file.mp3`.

    $ chaptan your-audio-file.mp3 -y your-chapters-file.yml


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nyoho/chaptan.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
