#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install

# Make sure the DATABASE_URL is available before any DB tasks run
bundle exec rails db:prepare

bundle exec rails assets:precompile
bundle exec rails assets:clean
