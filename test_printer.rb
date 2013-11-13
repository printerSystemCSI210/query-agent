require './printer'

def printer_info(ip)
    p = Printer.new(ip)
    puts "Name:      #{p.get_name}"
    puts "Location:  #{p.get_location}"
    puts "Model:     #{p.get_model}"
    puts "Serial:    #{p.get_serial}"
    puts "Message:   #{p.get_messages}"
    puts "Pagecount: #{p.get_page_count}"
    puts "Display:   #{p.get_display}"
    puts "Status:    #{p.get_status}"

    puts "Devices:"
    p.get_devices.each { |device| puts "    #{device[:name]}: #{device[:status]}" }

    puts "Consumables:"
    p.get_consumables.each { |cons| puts "    #{cons[:name]} (#{cons[:percentage]}%)" }

    puts "Trays:"
    p.get_trays.each { |tray| puts "    #{tray[:name]} (#{tray[:capacity]} sheets #{tray[:x]} x #{tray[:y]}): #{tray[:status]}"}
end

printers = ['192.168.130.238', '192.168.43.240', '192.168.130.249', '192.168.130.247', '192.168.134.240', '192.168.134.241', '192.168.135.247']

printers.each { |printer| printer_info(printer) }
