class DaysController < ApplicationController
  # GET /days
  # GET /days.xml
  def index
    @days = Day.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @days }
    end
  end

  # GET /days/1
  # GET /days/1.xml
  def show
    @day = Day.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @day }
    end
  end

  # GET /days/new
  # GET /days/new.xml
  def new
    @day = Day.new    
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @day }
    end
  end

  # GET /days/1/edit
  def edit
    @day = Day.find(params[:id])
  end

  # POST /days
  # POST /days.xml
  def create
    @day = Day.new(params[:day])
    @day.loadFileData(params[:csvData])
		month = Month.find(:first,:conditions => [ "year_number = ? and month = ?",@day.date.year,@day.date.month ])
		if(month == nil)
		 month = Month.new
		 month.year_number = @day.date.year
		 month.month = @day.date.month
		 year = Year.find(:first,:conditions => ["year = ?",@day.date.year])
		 if(year == nil)
			 year = Year.new
			 year.year = @day.date.year
			 year.save
		 end
		 month.year = year
		 month.save
		end
		@day.month = month
    respond_to do |format|
      if @day.save
        flash[:notice] = 'Day was successfully created.'
        format.html { redirect_to(@day) }
        format.xml  { render :xml => @day, :status => :created, :location => @day }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /days/1
  # PUT /days/1.xml
  def update
    @day = Day.find(params[:id])

    respond_to do |format|
      if @day.update_attributes(params[:day])
        flash[:notice] = 'Day was successfully updated.'
        format.html { redirect_to(@day) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @day.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /days/1
  # DELETE /days/1.xml
  def destroy
    @day = Day.find(params[:id])
    @day.destroy

    respond_to do |format|
      format.html { redirect_to(days_url) }
      format.xml  { head :ok }
    end
  end
end
