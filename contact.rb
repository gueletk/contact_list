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
