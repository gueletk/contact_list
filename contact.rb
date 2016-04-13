require 'pg'
require 'csv'
require 'byebug'
require 'active_record'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact < ActiveRecord::Base

  validates_presence_of :name
  validates :email, uniqueness: { case_sensitive: false }

  def self.search(term)
    where("name ILIKE ? OR email ILIKE ?", "%#{term}%", false)
  end

end
#
#   attr_accessor :name, :email, :id#, :phone_numbers
#
#   # Creates a new contact object
#   # @param name [String] The contact's name
#   # @param email [String] The contact's email address
#   def initialize(name, email, id = nil)#phone_numbers = [], id = nil)
#     @name = name
#     @email = email
#     #@phone_numbers = phone_numbers
#     @id = id
#   end
#
#   def save
#     if id
#       self.class.connection.exec_params('UPDATE contacts SET name=$1, email=$2 WHERE id = $3::int', [name, email, id])
#     else
#       self.class.connection.exec_params('INSERT INTO contacts (name, email) VALUES ($1, $2) RETURNING id;', [name, email]) do |id|
#         @id = id
#       end
#     end
#   end
#
#   def destroy
#     self.class.connection.exec_params('DELETE FROM contacts WHERE id=$1::int',[id])
#   end
#
#   # Provides functionality for managing contacts in the csv file.
#   class << self
#
#     # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
#     # @return [Array<Contact>] Array of Contact objects
#     def all
#       # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
#       contacts = []
#       connection.exec('SELECT * FROM contacts;') do |results|
#         results.each do |contact|
#           contacts << Contact.new(contact["name"], contact["email"], contact["id"])
#         end
#       end
#       contacts
#     end
#
#     # Creates a new contact, adding it to the csv file, returning the new contact.
#     # @param name [String] the new contact's name
#     # @param email [String] the contact's email
#     def create(name, email)
#       # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
#       contact = Contact.new(name, email)
#       contact.save
#       return contact
#     end
#
#     # Find the Contact in the 'contacts.csv' file with the matching id.
#     # @param id [Integer] the contact id
#     # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
#     def find(id)
#       connection.exec_params('SELECT * FROM contacts WHERE id = $1::int;', [id]) do |result|
#         result.each do |c|
#           contact = Contact.new(c["name"], c["email"], c["id"])
#           return contact
#         end
#       end
#     end
#
#     # Search for contacts by either name or email.
#     # @param term [String] the name fragment or email fragment to search for
#     # @return [Array<Contact>] Array of Contact objects.
#     def search(term)
#       # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
#       matches = []
#       search_string = connection.escape_string(term).downcase
#       connection.exec("SELECT * FROM contacts WHERE LOWER(name) LIKE '%#{search_string}%' OR LOWER(email) LIKE '%#{search_string}%';") do |result|
#         result.each do |c|
#           contact = Contact.new(c["name"], c["email"], c["id"])
#           matches << contact
#         end
#       end
#       matches
#     end
#
#     def connection
#       conn = PG.connect(
#         host: 'localhost',
#         dbname: 'contacts',
#         user: 'development',
#         password: 'development'
#       )
#     end
#   end
#
# end
