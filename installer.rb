#!/usr/bin/env ruby

require 'escort'
require 'my_app'

Escort::App.create do |app|
  app.options do |opts|
    opts.opt :option1, "Option 1", :short => '-o', :long => '--option1', :type => :string
    opts.opt :int1, "Int 1", :short => '-i', :long => '--int1', :type => :int
    opts.opt :option2, "Option 2", :short => :none, :long => '--option2', :type => :string

    opts.validate(:option1, "must be either 'foo' or 'bar'") { |option| ["foo", "bar"].include?(option) }
    opts.validate(:int1, "must be between 10 and 20 exclusive") { |option| option > 10 && option < 20 }
    opts.validate(:option2, "must be two words") {|option| option =~ /\w\s\w/}
    opts.validate(:option2, "must be at least 20 characters long") {|option| option.length >= 20}
  end

  app.action do |options, arguments|
    MyApp::ExampleCommand.new(options, arguments).execute
  end
end