# frozen_string_literal: true

# Copyright (c) 2025 kk
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

require 'time'

task default: %w[push]

task :push do
  system 'rubocop -A'
  system 'git update-index --chmod=+x push.rb'
  system 'git add .'
  system "git commit -m 'Update #{Time.now}'"
  system 'git pull'
  system 'git push origin main'
end

task :run do
  puts 'run'
end

task :docker do
  puts 'docker'
end
