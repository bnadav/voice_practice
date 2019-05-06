class ChaptersExaminationsController < ApplicationController

  before_action :admin?, :only => [:new, :edit, :create, :update, :destroy, :list, :index]

  # GET /chapters_examinations
  # GET /chapters_examinations.xml
  def index
    #@chapters_examinations = ChaptersExamination.find(:all,:order=>'examination_id,ind')
     @chapters_examinations = ChaptersExamination.all.order('examination_id').order(:ind)

       render layout: false

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @chapters_examinations }
     
	#end
     
  end

  # GET /chapters_examinations/1
  # GET /chapters_examinations/1.xml
  def show
    @chapters_examination = ChaptersExamination.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @chapters_examination }
    end
  end

  # GET /chapters_examinations/new
  # GET /chapters_examinations/new.xml
  def new
    @chapters_examination = ChaptersExamination.new
   
  end

  # GET /chapters_examinations/1/edit
  def edit
    @chapters_examination = ChaptersExamination.find(params[:id])
    @chapter=@chapters_examination.chapter
    @examination=@chapters_examination.examination
    ex = Examination.all
    @ce = ex.inject([]) {|mem, e| mem << e.chapters_examinations}.flatten!  
  end

  # POST /chapters_examinations
  def create
    chapter = Chapter.find(params[:chapter][:id])
    examination = Examination.find(params[:examination][:id])
    
    @chapters_examination = ChaptersExamination.new
    @chapters_examination.examination=examination
    @chapters_examination.chapter=chapter
    @chapters_examination.ind= params[:chapters_examinations][:ind]

      if @chapters_examination.save
        flash[:notice] = 'ChaptersExamination was successfully created.'
       redirect_to(chapters_examinations_url) 
       else
        render :action => "new" 
      end
  end

  # PUT /chapters_examinations/1
  def update
    @chapters_examination = ChaptersExamination.find(params[:id])
      #if @chapters_examination.update_attributes(params[:chapters_examination])
	  if @chapters_examination.update!(chapters_examination_params)
        flash[:notice] = 'ChaptersExamination was successfully updated.'
        redirect_to(chapters_examinations_url) 
      else
	   flash[:notice] = 'ChaptersExamination was successfully updated.'
       render :action => "edit" 
      end
  end

  # DELETE /chapters_examinations/1
  # DELETE /chapters_examinations/1.xml
  def destroy
    @chapters_examination = ChaptersExamination.find(params[:id])
    @chapters_examination.destroy

    respond_to do |format|
      format.html { redirect_to(chapters_examinations_url) }
      format.xml  { head :ok }
    end
  end
  
 #additional method for Ajax
 def show_ind
      indexes = ChaptersExamination.maximum(:ind,:group =>'examination_id')
      last_ind = indexes[params[:examination_id].to_i]
      @ind=(last_ind+1).to_s 
      render :partial => "ind_result",:layout=>false
      
   end   
    
   def chapters_examination_params
      params.require(:chapters_examination).permit(:examination_id, :ind, :chapter_id)
    end
  

end
