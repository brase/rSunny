require 'date'
require 'csv'
require 'fileutils'
require 'tmpdir'
require 'zip/zip'
require 'zip/zipfilesystem'
require 'uuidtools'

class Day < ActiveRecord::Base
  serialize :chart_array0
  serialize :chart_array1
  belongs_to :month
  after_save :calculate_sums
  after_destroy :calculate_sums
  
  validates_uniqueness_of :date

  def loadFileData(csvFile)
    self.csvData = csvFile.read
  	unit0_position = 1
  	unit1_position = 2
  	time_stamp = 0
    unit0_start = nil
    unit1_start = nil
    unit0_end = nil
    unit1_end = nil
  	read_kw = 0
  	chart_array0 = Array.new
  	chart_array1 = Array.new
  	last_value_unit0 = nil
  	last_value_unit1 = nil
    CSV.parse(self.csvData,:col_sep => ";") do |row|	  
      if( /^Version/.match( row[0] ) ||/^sep/.match( row[0] ) )
				if (/Tool SE/.match(row[0]))
					unit1_position = 3
					read_kw =1
				end
        next
      end
      begin
        date = Date.parse(row[0])
        self.date = date
		    time = Time.parse(row[0]).to_i		
      rescue
        next
      end
      if(unit0_start == nil)
        unit0_start = row[unit0_position]
      end
      if(unit1_start == nil)
        unit1_start = row[unit1_position]
      end
      if(row[unit0_position]!= nil)
        unit0_end = row[unit0_position]
        kw = 0
    		if(read_kw == 1)
    		  kw = row[unit0_position + 1].gsub(",",".").to_f    		  
    		else
    		  this_value_unit0 = row[unit0_position].gsub(",",".").to_f
    		  if(last_value_unit0 != nil)
    		    kw = (this_value_unit0 - last_value_unit0)*6
    		    last_value_unit0 = this_value_unit0
  		    else
  		      kw = 0
  		      last_value_unit0 = this_value_unit0
		      end
    		end        		
    		chart_array0.push([time,kw])
		  end
      if(row[unit1_position]!= nil)
        unit1_end = row[unit1_position]
        kw = 0
    		if(read_kw == 1)
    		  kw = row[unit1_position + 1].gsub(",",".").to_f    		  
    		else
    		  this_value_unit1 = row[unit1_position].gsub(",",".").to_f
    		  if(last_value_unit1 != nil)
      		  kw = (this_value_unit1 - last_value_unit1)*6		  
    		    last_value_unit1 = this_value_unit1
  		    else
  		      kw = 0
  		      last_value_unit1 = this_value_unit1
		      end
    		end
    		chart_array1.push([time,kw])
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
	  self.chart_array0 = chart_array0
	  self.chart_array1 = chart_array1
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

  def calculate_sums()
    logger.debug "before summed"
    self.month.sum_days
  	logger.debug "after summed"
  end
  
end