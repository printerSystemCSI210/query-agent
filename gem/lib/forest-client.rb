require 'json'
require 'net/http'
require 'uri'
require 'forest-client/printer'

module ForestClient
    class Forest

        def api_call(url)
            url = "https://forest-api.herokuapp.com/api/#{url}"
            url = URI.escape(url)
            url = URI.parse(url)
            content = Net::HTTP.get(url)
            return JSON.parse(content)
        end

        def initialize(org_id)
            @org_id = org_id
        end

        def get_printers
            url = "printerList?organizationId=#{@org_id}"
            printers = api_call(url)
            return printers['printers']
        end

        def get_printer(id)
            url = "printerGet?organizationId=#{@org_id}&printerId=#{id}"
            printer = api_call(url)
            return printer
        end

        def update_printer(printer)
            id = printer['id']
            ip = printer['ipAddress']

            p = Printer.new(ip)
            url = 'printerUpdate'
            url += '?printerId=' + id
            url += '&model=' + p.get_model
            url += '&location=' + p.get_location
            url += '&serial=' + p.get_serial
            api_call(url)
            return
        end

        def update_status(printer)
            id = printer['id']
            ip = printer['ipAddress']
            p = Printer.new(ip)

            url = 'statusCreate'
            url += '?printerId=' + id
            url += '&status=' + p.get_status
            url += '&pageCount=' + p.get_page_count.to_s

            trays = Array.new

            t = p.get_trays
            if t
                t.each { |tray|
                    trays.push({
                        'name' => tray[:name],
                        'xdim' => tray[:x],
                        'ydim' => tray[:y],
                        'capacity' => tray[:capacity]
                    })
                }
            end

            url += '&trays=' + trays.to_s.gsub!('=>', ':')

            consumables = Array.new

            c = p.get_consumables
            if c
                c.each { |cons|
                    consumables.push({
                        'name' => cons[:name],
                        'level' => cons[:level],
                        'capacity' => cons[:capacity],
                        'percentage' => cons[:percentage]
                     })
                }
            end

            url += '&consumables=' + consumables.to_s.gsub!('=>', ':')

            api_call url
        end

    end

    class QueryAgent

        def initialize(org_id)
            @org_id = org_id
        end

        def run
            forest = Forest.new(@org_id)

            printers = forest.get_printers
            if printers
                printers.each do |printer|    
                    forest.update_printer(printer)
                    forest.update_status(printer)
                end
            end
        end
    end
end
