require 'pg'
require 'pry'

class Phone

  attr_accessor :kind, :number, :id

  def initialize(kind, number, id = nil)
    @kind = kind
    @number = number
    @id = id
  end

  class << self

    def search(contact_id)
      phones = []
      connection.exec_params("SELECT * FROM phone_numbers WHERE contact_id = $1", [contact_id]) do |result|
        result.each do |phone|
          phones << Phone.new(phone["kind"].strip, phone["number"].strip, phone["id"])
        end
      end
      pp phones
    end

    def connection
      conn = PG.connect(
        host: 'localhost',
        dbname: 'contacts',
        user: 'development',
        password: 'development'
      )
    end
  end

end

Phone.search(2)
