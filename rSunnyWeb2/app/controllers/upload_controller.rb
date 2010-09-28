require 'uuidtools'
class UploadController < ApplicationController
	def index

  end

	def uploadFile
    loadFromZip(params[:zipFile])
		redirect_to :controller => "days"
  end

	def loadFromZip(zipFile)
		name =  zipFile.original_filename
		uuid = rand.hash.to_s + rand.hash.to_s
		extractDir = "public/data/" + uuid.to_s
		Dir.mkdir(extractDir)
    # create the file path
    path = File.join(extractDir, name)
    # write the file
    File.open(path, "wb") { |f| f.write(zipFile.read) }

		zf = Zip::ZipFile.open(extractDir + "/" + name)
		zf.each do |zip|
			fpath = File.join(extractDir, zip.name)
			 if(File.exists?(fpath))
        File.delete(fpath)
      end
      zf.extract(zip, fpath)
		end
		csvFiles = File.join(extractDir,"*.CSV")
		#logger.debug "csvFilesPath"
		#logger.debug csvFiles;
		files = Dir.glob(csvFiles)
		files.each do |e|
			#logger.debug "FilePath:"
			 #logger.debug e
			 file = File.new(e, 'r')
			 day = Day.new
			 day.loadFileData(file)
			 month = Month.find(:first,:conditions => [ "year_number = ? and month = ?",day.date.year,day.date.month ])
			 if(month == nil)
				 month = Month.new
				 month.year_number = day.date.year
				 month.month = day.date.month
				 year = Year.find(:first,:conditions => ["year = ?",month.year_number])
		     if(year == nil)
			     year = Year.new
			     year.year = month.year_number
			     year.save
		     end
				 month.year = year
				 month.save
			 end
			 day.month = month
			 day.save
		end
		logger.log "delete Dir"
		FileUtils.rm_r Dir.glob(extractDir)
	end
end
