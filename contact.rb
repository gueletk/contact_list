require 'csv'
require 'byebug'

# Represents a person in an address book.
# The ContactList class will work with Contact objects instead of interacting with the CSV file directly
class Contact

  attr_accessor :name, :email

  # Creates a new contact object
  # @param name [String] The contact's name
  # @param email [String] The contact's email address
  def initialize(name, email)
    @name = name
    @email = email
  end

  # Provides functionality for managing contacts in the csv file.
  class << self

    # Opens 'contacts.csv' and creates a Contact object for each line in the file (aka each contact).
    # @return [Array<Contact>] Array of Contact objects
    def all
      # TODO: Return an Array of Contact instances made from the data in 'contacts.csv'.
      contacts = []
      CSV.foreach('contacts.csv') do |row|
        unless $. == 1 then
          contacts << Contact.new(row[0], row[1])
        end
      end
      contacts
    end

    # Creates a new contact, adding it to the csv file, returning the new contact.
    # @param name [String] the new contact's name
    # @param email [String] the contact's email
    def create(name, email)
      # TODO: Instantiate a Contact, add its data to the 'contacts.csv' file, and return it.
      contact = Contact.new(name, email)
      CSV.open('contacts.csv', 'ab') do |csv|
        csv << [name, email]
      end
      return contact
    end

    # Find the Contact in the 'contacts.csv' file with the matching id.
    # @param id [Integer] the contact id
    # @return [Contact, nil] the contact with the specified id. If no contact has the id, returns nil.
    def find(id)
      # TODO: Find the Contact in the 'contacts.csv' file with the matching id.
      CSV.foreach('contacts.csv') do |row|
        if $. == id + 1 then
          contact = Contact.new(row[0], row[1])
          return contact
        end
      end
    end

    # Search for contacts by either name or email.
    # @param term [String] the name fragment or email fragment to search for
    # @return [Array<Contact>] Array of Contact objects.
    def search(term)
      # TODO: Select the Contact instances from the 'contacts.csv' file whose name or email attributes contain the search term.
      matches = []
      r_term = Regexp.new(term, Regexp::IGNORECASE)
      CSV.foreach('contacts.csv') do |row|
        if r_term.match(row[0]) || r_term.match(row[1])
          matches << [Contact.new(row[0], row[1]), $. + 1]
        end
      end
      matches
    end

  end

end
