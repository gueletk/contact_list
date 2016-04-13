require 'pry' # in case you want to use binding.pry
require 'active_record'
require_relative 'contact'

# Output messages from Active Record to standard out
ActiveRecord::Base.logger = Logger.new('contact.log')

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contacts',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'

puts 'Setting up Database (recreating tables) ...'

ActiveRecord::Schema.define do
  drop_table :contact if ActiveRecord::Base.connection.table_exists?(:contact)
  #drop_table :employees if ActiveRecord::Base.connection.table_exists?(:employees)
  create_table :contact do |t|
    t.column :name, :string
    t.column :email, :string
  end
  # create_table :employees do |table|
  #   table.references :store
  #   table.column :first_name, :string
  #   table.column :last_name, :string
  #   table.column :hourly_rate, :integer
  #   table.timestamps null: false
  # end
end

puts 'Setup DONE'
