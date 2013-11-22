#!/usr/bin/ruby

require 'forest-client'

def setup
    
    # get ID from user
    puts "\n        Welcome to Forest! \n"
    puts "---------------------------------- \n"
    puts "Please enter your 24-character Organization ID below."
    print "id: "
    id = gets.chomp

    # write to file
    file = File.open('forest.id', 'w')
    file.write(id)
    file.close
    
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
        id = read_config
    rescue
        id = setup
    end


    qa = ForestClient::QueryAgent.new(id)
    qa.run
end

main
