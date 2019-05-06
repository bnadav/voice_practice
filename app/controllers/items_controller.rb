class ItemsController < ApplicationController
  
  before_filter :fetch_chapter_id ,:only => [:index]
  before_action :admin?, :only => [:new, :edit, :create, :update, :destroy, :list]

  
  
  def index
  #?  @chapters=@examination.chapters.find(:all, :order =>'ind')
	
   #4 @ind=ChaptersExamination.find_by_chapter_id_and_examination_id(
   #4                                         params[:chapter_id],
   #4                                         params[:examination_id]).ind    
   
	
	

   @ind=ChaptersExamination.where(chapter_id: params[:chapter_id],
                                  examination_id: params[:examination_id]).first.ind
 
	 logger.info("lang=#{session[:lang]}")
	
    #4 @chapter_items = @chapter.items.find(:all,
    #4        :conditions =>[ "examination_id is NULL or examination_id = ?" ,params[:examination_id]],
    #4        :order=> 'ind')   
    
	 @chapter_items = @chapter.items.where("examination_id is NULL or examination_id = ?" ,params[:examination_id]).order(:ind)


     end

  
  def items_asx
     #Item.find(:all, :conditions => "number > -1")
    chapter= Chapter.find(params[:chapter_id].to_i)    
    @items = chapter.items.non_instructions 
    
    @items.each do | item|
      
      if item.kernel?   #kernel      
        @filename=item.text  
        @parts_number = item.parts_number              
        logger.info("PARTS NUMBER=={#@parts_number} for {#@filename}")
        asx_str = render_to_string :action=>"kernel_asx", :layout => false  
		
		 
      elsif item.question?  #question 
        @filename=item.question
        asx_str = render_to_string :action=>"question_asx", :layout => false  
		
		  
      end
      
      #logger.info("*** #{@filename}: #{asx_str}")      
      
      item.write_to_asx_file(@filename, asx_str)             
      
    end
    render :text => "Finished creating play lists"
  end  

    def list
     @chapter=Chapter.find(params[:chapter_id].to_i)
     @chapter_items= @chapter.items
	 render layout: 'list'

   end

   
   # GET /items/new
  def new
    @chapter=Chapter.find(params[:chapter_id])
    @item = Item.new
    @item.chapter=@chapter
    @item.ind=@chapter.items.count+1
    
  end

  # GET /items/1/edit
  def edit
    @chapter=Chapter.find(params[:chapter_id].to_i)
    @item = Item.find(params[:id])
  end

  # POST /examinations
  def create
    @item = Item.new
      if @item.create_by_params(params)
     	flash[:notice] = 'Item was successfully created.'
        redirect_to(list_chapter_items_url) 
       else
         render :action => "new" 
      end
  end

  # PUT /items/1
   def update
     @item=Item.find(params[:id])
  
      if @item.save_params(params[:item],params[:chapter_id])
        flash[:notice] = 'Item was successfully updated.'
        redirect_to(list_chapter_items_url) 
      else
        render :action => "edit" 
      end
  end

  # DELETE /items/1
 def destroy
    
    @item = Item.find(params[:id])
    @item.destroy

    redirect_to(list_chapter_items_url) 
    end
  
 



private

  def fetch_chapter_id  

    I18n.locale = session[:lang] 
    @examination = Examination.find(params[:examination_id])
    @chapter = @examination.chapters.find(params[:chapter_id])
   
  
  end

  def item_params
      params.require(:item).permit(:name, :age)
    end
  
end
