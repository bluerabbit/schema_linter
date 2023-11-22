# frozen_string_literal: true

require 'rails/all'
require 'action_controller/railtie'

require 'schema_linter'

module DummyApp
  class Application < Rails::Application
    config.root = File.expand_path(__dir__)
  end
end

ActiveRecord::Base.establish_connection(
  YAML.safe_load(ERB.new(File.read('spec/database.yml')).result, aliases: true)['test']
)

ActiveRecord::Schema.define version: 0 do
  create_table :users, force: true do |t|
    t.string :name
    t.string :role
  end

  create_table :configurations, force: true do |t|
    t.string :service_name
  end
end

class User < ActiveRecord::Base
end

class Configuration < ActiveRecord::Base
end
