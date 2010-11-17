require 'date'
require 'csv'

class Day < ActiveRecord::Base
    
  def loadFileData(day)
    file = day['csvData']
    self.csvData = file.read
    puts CSV
  end
end


