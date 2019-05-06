class ChaptersController < ApplicationController

 before_action :admin?, :only => [:new, :edit, :create, :update, :destroy, :list]

# GET /chapters
   def index
    @chapters = Chapter.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @chapters }
    end
  end


 def edit
    @chapter = Chapter.find(params[:id])
  
  end
  
  
  # PUT /chapter/1
  def update
    @chapter = Chapter.find(params[:id])

      if @chapter.update_attributes(chapter_params)
        flash[:notice] = 'chapter was successfully updated.'
        redirect_to(list_chapters_url)
       else
       render :action => "edit" 
      end
   
  end
  
   #GET / chapter/new
   def new
       @chapter = Chapter.new
   end  
  
   # POST /chapters
  # POST /chapters.xml
  def create
    @chapter = Chapter.new(chapter_params)
     
     if @chapter.save   
      flash[:notice] = 'Chapter was successfully created.'
          redirect_to(list_chapters_url)         
      else
          render :action => "new" 
      end    
  end
  
  
  # DELETE /chapters/1
  def destroy
    @chapter = Chapter.find(params[:id])
    @chapter.destroy
    
      redirect_to(list_chapters_url) 
  
end
  
  #addition method for editing the chapters
  def list
     @chapter = Chapter.all.order('number') 
      render layout: false

  end

 def chapter_params
      params.require(:chapter).permit(:number, :name, :show_formulas, :lang)
    end
end
