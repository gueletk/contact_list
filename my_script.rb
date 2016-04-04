require 'pry'
require_relative 'contact_list'

if !ARGV[0]
  ContactList.main_menu    
end
