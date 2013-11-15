require './forest'

forest = Forest.new('527add43c1781f0200000001')

printers = forest.get_printers
printers.each do |printer|    
    forest.update_printer(printer)
    forest.update_status(printer)
end
