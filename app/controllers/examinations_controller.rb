class ExaminationsController < ApplicationController
  # GET /examinations
  # GET /examinations.xml
 before_filter :fetch_lang ,:only => [:index, :show]
 before_action :admin?, :only => [:new, :edit, :create, :update, :destroy, :list]
  
  def index
   # @examinations = Examination.find(:all,:order =>'number')
  lang = session[:lang] 
   #I18n.locale = lang
   logger.info("**** Lang is #{I18n.locale}")
   exam_type = session[:exam_type]
 #4  @examinations = Examination.find_all_by_lang_and_exam_type(lang,exam_type, :order =>'number')
    @examinations = Examination.where(lang: lang , exam_type: exam_type).order('number')
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @examinations }
    end
  end

  # GET /examinations/1
  # GET /examinations/1.xml
  def show
    @examination = Examination.find(params[:id])
   #4 @chapters =@examination.chapters.find(:all,:order=>'ind')  
   @chapters =@examination.chapters.order('ind')  
 end

  # GET /examinations/new
  # GET /examinations/new.xml
  def new
    @examination = Examination.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @examination }
    end
  end

  # GET /examinations/1/edit
  def edit
    @examination = Examination.find(params[:id])
  end

  # POST /examinations
  # POST /examinations.xml
  def create
    @examination = Examination.new(examination_params)
    @examination.number = Examination.count+1
    respond_to do |format|
      if @examination.save
        flash[:notice] = 'Examination was successfully created.'
        format.html { redirect_to(list_examinations_url)  }
        format.xml  { render :xml => @examination, :status => :created, :location => @examination }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @examination.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /examinations/1
  # PUT /examinations/1.xml
  def update
    @examination = Examination.find(params[:id])

    respond_to do |format|
      if @examination.update(examination_params)
	  #4 if @examination.update_attributes(params[:examination])
        flash[:notice] = 'Examination was successfully updated.'
        format.html { redirect_to(list_examinations_url)  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @examination.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /examinations/1
  # DELETE /examinations/1.xml
  def destroy
    @examination = Examination.find(params[:id])
    @examination.destroy

    respond_to do |format|
      format.html { redirect_to(list_examinations_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def list
     @examinations = Examination.all.order(:number)
	    render layout: 'list'

  end


def instructions
   @exam = Examination.find(params[:id].to_i)
    session[:lang] = @exam.lang   #save the date in session for index to select only the relevant exams
    session[:exam_type] = @exam.exam_type
   render :action => "instructions_#{@exam.lang}_#{@exam.exam_type}"
end  
  
def exam_choice
  lang = params[:lang] || "hebrew"
 
  @psycho_exam = Examination.find_practice_exam(lang,"psycho")
  @amir_exam =  Examination.find_practice_exam(lang,"amir")
  @yael_exam =  Examination.find_practice_exam(lang,"yael")
  @engchaps_exam =  Examination.find_practice_exam(lang,"engchaps")
 
  render :action => "exam_choice_#{lang}"  
end
  

def fetch_lang
   I18n.locale  = session[:lang] 
end   
  
def examination_params
   params.require(:examination).permit(:name, :instruction, :lang, :exam_type,:number)

end 

end
