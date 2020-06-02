ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

configure :development do
  set :database, 'sqlite3:db/database.db'
end

def fi_check_migration
  begin
    ActiveRecord::Migration.check_pending!
  rescue ActiveRecord::PendingMigrationError
    raise ActiveRecord::PendingMigrationError.new <<-EX_MSG
Migrations are pending. To resolve this issue, run:
      rake db:migrate SINATRA_ENV=test
EX_MSG
  end
end

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)
require 'rack-flash'
require '/home/christopher/playlister-sinatra-online-web-sp-000/app/models/concerns/slugifiable.rb'
require_all 'app'
require_all 'lib'
configure :development do
  set :database, 'sqlite3:db/database.db'
end
