require 'rubygems'
require_relative 'lib/freesouls_cc.rb'

desc "Fetch Flickr data"
task :sync do
  fcc = FreesoulsCC::Flickr.new()
  fcc.sync("freesoulsbook")
end

desc "Generate templates"
task :generate do
  gen = FreesoulsCC::Jekyll.new("freesoulsbook")
  gen.gen
end
