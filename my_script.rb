require 'pry'
require_relative 'contact_list'

case ARGV[0]
when nil
  ContactList.main_menu
when "list"
  ContactList.display_all
end
