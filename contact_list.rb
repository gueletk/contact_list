require_relative 'contact'

# Interfaces between a user and their contact list. Reads from and writes to standard I/O.
class ContactList

  def main_menu()
    puts "Here is a list of available commands:"
    puts "\t new          - Create a new contact"
    puts "\t list         - List all contacts"
    puts "\t show <id>    - Show specified contact"
    puts "\t search       - Search contacts"
    puts "\t update <id>  - update specified contact"
    puts "\t destroy <id> - Deletes specified contact"
  end

  def list()
    contacts = Contact.all
    contacts.each do |contact|
      puts "#{contact.id}. #{contact.name} (#{contact.email})"
    end
    puts "\n#{contacts.length} records total"
  end

  def add_contact()
    puts "Please enter the full name of the contact."
    name = STDIN.gets.chomp
    puts "Please enter the contact's email address"
    email = STDIN.gets.chomp
    begin
      new_contact = Contact.create(name, email)
      puts "The following contact has been created:\n"
      puts "#{new_contact.name} (#{new_contact.email})"
    rescue PG::UniqueViolation
      puts "Sorry, a contact with that email address already exists"
    end
  end

  def show(id)

    begin
      contact = Contact.find(id)
      puts "The contact with the id \##{contact.id} is:"
      puts "#{contact.name}"
      puts "#{contact.email}"
    rescue
      puts "Sorry, there is no contact with id \##{id}"
    end
  end

  def search(term)
    if !term || term == ""
      puts "Cannot search for empty string"
      return
    end
    results = Contact.search(term)
    results.each do |contact, id|
      puts "#{id}. #{contact.name} (#{contact.email})"
    end
    puts "\n#{results.length} records total found"
  end

  def update(id)
    contact = Contact.find(id)
    puts "The current name for this contact is #{contact.name}. What should it be? (Press Enter to skip to the email)"
    new_name = STDIN.gets.chomp
    contact.name = new_name unless new_name == ""
    puts "The current email for this contact is #{contact.email}. What should it be? (Press Enter to skip and save)"
    new_email = STDIN.gets.chomp
    contact.email = new_email unless new_email == ""
    begin
      contact.save
      puts "Contact \##{contact.id} has been updated."
      Contact.find(id)
    rescue PG::UniqueViolation
      puts "Could not update contact, that email address already exists."
    end
  end

  def destroy(id)
    contact = Contact.find(id)
    begin
      contact.destroy
      puts "Contact #{id} has been deleted."
    rescue
      puts "A contact with that ID does not exits and could not be deleted."
    end
  end
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
when "update"
  contacts.update(ARGV[1])
when "destroy"
  contacts.destroy(ARGV[1])
end
