#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require 'rake/dsl_definition'

require File.expand_path('../config/application', __FILE__)

IdeaApp::Application.load_tasks

# May need this to run sunspot rake tasks on Heroku
require 'sunspot/rails/tasks'
