# frozen_string_literal: true

RSpec.describe Chaptan do
  it "has a version number" do
    expect(Chaptan::VERSION).not_to be nil
  end

  it "has a command" do
    expect(Chaptan::Command.new(ARGV)).not_to be nil
  end
end

# TODO:
# Add a test that the following successfully adds chapters
# $ cp resources/example.mp3 /tmp/some_unique_directory_name
# $ bundle exec exe/chaptan -y resources/chapters.yml /tmp/some_unique_directory_name/example.mp3

# TODO:
# Add a test that it successfully shows chapters
# $ bundle exec exe/chaptan resources/example.mp3
