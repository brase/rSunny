require 'date'
require 'csv'
require 'fileutils'
require 'tmpdir'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'uuidtools'

class Day < ActiveRecord::Base
    
  def loadFileData(csvFile)    
    self.csvData = csvFile.read
		unit0 = 1
		unit1 = 2
    unit0_start = nil
    unit1_start = nil
    unit0_end = nil
    unit1_end = nil
    CSV.parse(self.csvData,:col_sep => ";") do |row|
      if( /^Version/.match( row[0] ) ||/^sep/.match( row[0] ) )     
				if (/Tool SE/.match(row[0]))
					unit1 = 3
				end
        next
      end
      begin                
        date = Date.parse(row[0])        
        self.date = date				
      rescue
        next
      end
      if(unit0_start == nil)
        unit0_start = row[unit0]
      end
      if(unit1_start == nil)
        unit1_start = row[unit1]
      end
      if(row[unit0]!= nil)
        unit0_end = row[unit0]
      end
      if(row[unit1]!= nil)
        unit1_end = row[unit1]
      end      
    end
		if(unit0_start == nil)
			unit0_start = "0"
		end
		if(unit1_start == nil)
			unit1_start = "0"
		end
		if(unit0_end == nil)
			unit0_end = "0"
		end
		if(unit1_end == nil)
			unit1_end = "0"
		end
    unit0_start = unit0_start.gsub(",",".")
    unit1_start = unit1_start.gsub(",",".")
    unit0_end = unit0_end.gsub(",",".")
    unit1_end = unit1_end.gsub(",",".")
    self.sum_unit0 = unit0_end.to_f - unit0_start.to_f
    self.sum_unit1 = unit1_end.to_f - unit1_start.to_f
  end
	
	def loadFromZip(zipFile)
		name =  upload['datafile'].original_filename
    directory = "public/data"
    # create the file path
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
		uuid = UUID.random_create
		extractDir = "public/data/" + uuid.to_s		
		Dir.mkdir(extractDir)
		Zip::ZipFile.open("public/data/" + name).each do |single_file|
			single_file.extract(single_file.name,extractDir )
		end
		files = Dir.glob(extractDir + "/*.csv")
		files.each do |e| 
			 day = Day.new
			 day.loadFileData(e)
			 day.save
		end
	end
end