#!/usr/bin/ruby

require 'forest-client'

def setup
    
    # get ID from user
    puts "\n                 Welcome to Forest! \n"
    puts "----------------------------------------------------- \n"
    puts "Please enter your 24-character Organization ID below."
    print "id: "
    id = gets.chomp

    # write to file
    file = File.open('forest.id', 'w')
    file.write(id)
    file.close

    puts "Thanks! You won't have to do that again :)"
    
    return id
end

def read_config
    
    # ensure file exists
    raise 'Unable to open file' unless File.exist? 'forest.id'
    
    # read Org ID
    file = File.open('forest.id', 'r')
    org_id = file.read
    file.close

    return org_id
end

def main
    
    begin
        # Try to read ID
        id = read_config
    rescue
        # If we can't read the ID, prompt the user
        id = setup
    end

    qa = ForestClient::QueryAgent.new(id)
    qa.run

    puts "We just queried the printers you've added to Forest!"
    puts "Check your web console for details!"
end

main
