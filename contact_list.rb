require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def self.main_menu()
    puts "Here is a list of available commands:"
    puts "\t new    - Create a new contact"
    puts "\t list   - List all contacts"
    puts "\t show   - Show a contact"
    puts "\t search - Search contacts"
  end

  def self.display_all()
    contacts_arr = Contact.all
    contacts_arr.each.with_index do |contact, index|
      puts "#{index + 1}. #{contact.name} (#{contact.email})"
    end
    puts "\n#{contacts_arr.length} records total"
  end

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end
