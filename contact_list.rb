require_relative 'contact'


# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def main_menu()
    puts "Here is a list of available commands:"
    puts "\t new    - Create a new contact"
    puts "\t list   - List all contacts"
    puts "\t show   - Show a contact"
    puts "\t search - Search contacts"
  end

  def list()
    contacts = Contact.all
    contacts.each.with_index do |contact, index|
      puts "#{index + 1}. #{contact.name} (#{contact.email})"
    end
    puts "\n#{contacts.length} records total"
  end

  def add_contact()
    puts "Please enter the full name of the contact."
    name = STDIN.gets.chomp
    puts "Please enter the contact's email address"
    email = STDIN.gets.chomp
    same_email_contacts = Contact.search(email)
    if same_email_contacts != []
      puts "Sorry, a contact with that email address already exists"
      same_email_contacts.each do |contact, id|
        puts "#{id}. #{contact.name} (#{contact.email})"
      end
    else
      new_contact = Contact.create(name, email)
      puts "The following contact has been created:\n"
      puts "#{new_contact.name} (#{new_contact.email})"
    end
  end

  def show(id)
    contact = Contact.find(id)
    begin
      puts "The contact with the id \##{id} is:" if contact
      puts "#{contact.name}"
      puts "#{contact.email}"
    rescue
      puts "Sorry, there is no contact with id \##{id}"
    end
  end

  def search(term)
    results = Contact.search(term)
    results.each do |contact, id|
      puts "#{id}. #{contact.name} (#{contact.email})"
    end
    puts "\n#{results.length} records total found"
  end

  # TODO: Implement user interaction. This should be the only file where you use `puts` and `gets`.

end

contacts = ContactList.new()

case ARGV[0]
when nil
  contacts.main_menu
when "list"
  contacts.list
when "new"
  contacts.add_contact
when "show"
  contacts.show(ARGV[1].to_i)
when "search"
  contacts.search(ARGV[1])
end
