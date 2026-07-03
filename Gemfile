# frozen_string_literal: true

source "https://rubygems.org"

gem "jekyll-theme-chirpy", "~> 7.6"

# Ruby 3+/4에서 표준 라이브러리에서 제외됨 — `jekyll serve`(로컬 프리뷰)에 필요
gem "webrick", "~> 1.8"

gem "html-proofer", "~> 5.0", group: :test

platforms :windows, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.2.0", :platforms => [:windows]
