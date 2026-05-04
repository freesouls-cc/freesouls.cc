require 'rubygems'

require_relative 'config/config.rb'
require_relative 'lib/freesouls_cc.rb'

desc "Fetch Flickr data"
task :sync do
  fcc = FreesoulsCC::Flickr.new(FLICKR_API_KEY, FLICKR_API_SECRET)
  fcc.sync(FLICKR_QUERIES, "photos")
end

desc "Generate templates"
task :gen do
  gen = FreesoulsCC::Jekyll.new("photos")
  gen.gen(FLICKR_QUERIES)
end

desc "Clean templates"
task :gen_clean do
  gen = FreesoulsCC::Jekyll.new("photos")
  gen.clean(FLICKR_QUERIES)
end

# --- Vendored assets ---

MILLIGRAM_VERSION  = "1.2.4"
NORMALIZE_VERSION  = "8.0.1"
WORK_SANS_VERSION  = "1.6"
VENDOR             = "vendor"

MILLIGRAM_CSS = "#{VENDOR}/milligram/milligram.min.css"
NORMALIZE_CSS = "#{VENDOR}/normalize.css/normalize.css"
WORK_SANS_DIR = "#{VENDOR}/Work-Sans-#{WORK_SANS_VERSION}"

file MILLIGRAM_CSS do
  mkdir_p File.dirname(MILLIGRAM_CSS)
  sh "curl -fsSL https://unpkg.com/milligram@#{MILLIGRAM_VERSION}/dist/milligram.min.css \
      -o #{MILLIGRAM_CSS}"
end

file NORMALIZE_CSS do
  mkdir_p File.dirname(NORMALIZE_CSS)
  sh "curl -fsSL https://unpkg.com/normalize.css@#{NORMALIZE_VERSION}/normalize.css \
      -o #{NORMALIZE_CSS}"
end

file WORK_SANS_DIR do
  zip = "#{VENDOR}/work-sans-#{WORK_SANS_VERSION}.zip"
  mkdir_p VENDOR
  sh "curl -fsSL https://github.com/weiweihuanghuang/Work-Sans/archive/refs/tags/v#{WORK_SANS_VERSION}.zip \
      -o #{zip}"
  sh "unzip -n #{zip} -d #{VENDOR}"
  rm zip
end

desc "Install all vendored assets"
task install: [MILLIGRAM_CSS, NORMALIZE_CSS, WORK_SANS_DIR]

desc "Remove vendored assets"
task :vendor_clean do
  rm_rf [File.dirname(MILLIGRAM_CSS), File.dirname(NORMALIZE_CSS), WORK_SANS_DIR]
end
