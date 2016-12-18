require 'rubygems'
require_relative 'lib/freesouls_cc.rb'

desc "Fetch Flickr data"
task :sync do
  fcc = FreesoulsCC::Flickr.new()
  fcc.sync("freesoulsbook", "freesoulsbook.json")
end
