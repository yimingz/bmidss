class BmisController < ApplicationController
  # GET /bmis
  # GET /bmis.json
  def index
      @bmis = ''


    end

  # GET /bmis/1
  # GET /bmis/1.json
  def show
    @bmi = Bmi.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bmi }
    end
  end

  # GET /bmis/new
  # GET /bmis/new.json
  def new
    @bmi = Bmi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bmi }
    end
  end

  # GET /bmis/1/edit
  def edit
    @bmi = Bmi.find(params[:id])
  end

  # POST /bmis
  # POST /bmis.json
  def create
    @bmi = Bmi.new(params[:bmi])

    respond_to do |format|
      if @bmi.save
        format.html { redirect_to @bmi, notice: 'Bmi was successfully created.' }
        format.json { render json: @bmi, status: :created, location: @bmi }
      else
        format.html { render action: "new" }
        format.json { render json: @bmi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bmis/1
  # PUT /bmis/1.json
  def update
    @bmi = Bmi.find(params[:id])

    respond_to do |format|
      if @bmi.update_attributes(params[:bmi])
        format.html { redirect_to @bmi, notice: 'Bmi was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bmi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmis/1
  # DELETE /bmis/1.json
  def destroy
    @bmi = Bmi.find(params[:id])
    @bmi.destroy

    respond_to do |format|
      format.html { redirect_to bmis_url }
      format.json { head :ok }
    end
  end
  
  def calculate
      height_feet = params[:height_feet].to_f
      height_inch = params[:height_inch].to_f
          
      height = (height_feet*12)+height_inch
      
      weight_lb = params[:weight_lb].to_f
      
      height_cm = params[:height_cm].to_f
      weight_kg = params[:weight_kg].to_f
      
      @bmi = ((weight_lb * 703) /(height * height)).round(2)
     
  end
  
end
