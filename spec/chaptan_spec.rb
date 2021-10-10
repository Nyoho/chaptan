# frozen_string_literal: true

RSpec.describe Chaptan do
  it "has a version number" do
    expect(Chaptan::VERSION).not_to be nil
  end

  it "has a command" do
    expect(Chaptan::Command.new(ARGV)).not_to be nil
  end
end
