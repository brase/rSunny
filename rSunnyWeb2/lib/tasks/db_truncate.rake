namespace :db do
  task :load_config => :rails_env do
      require 'active_record'
          ActiveRecord::Base.configurations = Rails::Configuration.new.database_configuration
	    end
	     
	       desc "Create Sample Data for the application"
	         task(:truncate => :load_config) do
		    begin
		        config = ActiveRecord::Base.configurations[RAILS_ENV]
			    ActiveRecord::Base.establish_connection
			        case config["adapter"]
				      when "mysql"
				              ActiveRecord::Base.connection.tables.each do |table|
					                ActiveRecord::Base.connection.execute("TRUNCATE #{table}")
							        end
								      when "sqlite", "sqlite3"
								              ActiveRecord::Base.connection.tables.each do |table|
									                ActiveRecord::Base.connection.execute("DELETE FROM #{table}")
											          ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence where name='#{table}'")
												          end                                                                                                                               
													         ActiveRecord::Base.connection.execute("VACUUM")
														      end
														           rescue
															         $stderr.puts "Error while truncating. Make sure you have a valid database.yml file and have created the database tables before running this command. You should be able to run rake db:migrate without an error"
																     end
																       end
																       end
