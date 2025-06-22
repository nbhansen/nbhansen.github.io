# frozen_string_literal: true

source "https://rubygems.org"

# Use the latest Beautiful Jekyll theme
gem "beautiful-jekyll-theme", "~> 6.0.1"

# Jekyll 4.x for better Ruby 3.4 compatibility
gem "jekyll", "~> 4.3"

# Required for Ruby 3.4+ compatibility
gem "csv", "~> 3.0"
gem "base64"
gem "logger"

# Performance and compatibility
gem "webrick", "~> 1.8"

group :jekyll_plugins do
  gem "jekyll-paginate", "~> 1.1"
  gem "jekyll-sitemap", "~> 1.4"
  gem "jekyll-feed", "~> 0.17"
end

# Windows and JRuby compatibility
platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# Performance booster for watching directories on Windows
gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]