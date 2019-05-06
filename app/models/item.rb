class Item < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :examination
  

 
#4  scope :non_instructions, :conditions =>  "number > -1"
  
  scope :non_instructions, ->{ where  :number > -1}
  
  validates_uniqueness_of :question, :scope => [:chapter_id,:examination_id],
                                                 :allow_nil=>true
                                                 #:on =>:create,:update
                                                 
  validates_uniqueness_of :ind, :scope => [:chapter_id,:examination_id]
                                                
  validates_uniqueness_of :text, :scope => [:chapter_id],
                                            :allow_nil=>true
                                           # :on =>:create
  validates_presence_of :ind, :number
  
  validates_numericality_of :number, :only_integer=>true
  validates_numericality_of :ind, :only_integer=>true
  
  def validate_on_create
      if (select_type=="1" && number.blank?)
        errors.add(:number,"no question number specified")
        return
    
      elsif ((kernel? && text.blank?)  || (instruction? && instructions.blank?) || (essay? && question.blank?)
           (question? && question.blank?) )
        errors.add_to_base("no file name specified")    
       return        
    end
      
    if (question? )
        same_number =chapter.items.find_all_by_number(number)
        if (!same_number.empty? && examination_id.blank?)
          errors.add(:number,"use different question number")
          return
        elsif (!same_number.empty? && !examination_id.blank?) 
          same_number_and_exam = chapter.items.find_all_by_number_and_examination_id(number,examination_id)
          if (!same_number_and_exam.empty?)
            errors.add_to_base("change question number or examination_id")
            return
          end
       end
   end
    same_ind = chapter.items.find_all_by_ind(ind)   
    if (!same_ind.empty? && examination_id.blank?)    
      errors.add(:ind,"use different index")
      return
    elsif( !same_ind.empty? && !examination_id.blank?)  
      same_ind_and_exam = chapter.items.find_all_by_ind_and_examination_id(ind,examination_id)
      if ( !same_ind_and_exam.empty? )
          errors.add_to_base("change index or examination_id")   
          return
        end
     end        
  end

   def essay?
     number == -2
   end

   def kernel?
     number == 0
   end
   
   def question?
      number > 0
    end
    
    def instruction?
      number == -1
    end
  
  def name
     return text if kernel?
     return instructions if instruction?
	 return question if essay?
     return question
  end  
  
  
  
  def select_type
     return -1 if  instruction? 
     return 0 if kernel?
	 return -2 if essay?
     return 1
  end
  
  def examination?
     return examination.name if examination_id!=nil
     return ""
  end

  def quest_number(chapter)
    num=chapter.items.find(:all,:conditions=>"number>=1").size+1
     return num
   end     
    
  def suggest_name(chapter,type)
     if type>0 #question
        name=chapter.number.to_s+"_"+quest_number(chapter).to_s
     elsif type==0 #kernel
        num=chapter.items.find(:all,:conditions=>"number=0").size+1
        name=chapter.number.to_s+"_txt"+num.to_s
     else  
        #num=chapter.items.find(:all,:conditions=>"number=-1").size+1
        name=chapter.number.to_s+"_"+(quest_number(chapter)-1).to_s+"I"
     end   
     return name     
  end



def create_by_params(params)
  item_type=params[:item][:select_type]
   
  if item_type=="-1"
    self.number=-1
    self.instructions=params[:name]
    self.text=params[:item][:text]

  elsif item_type=="-2"
    self.number=-2
    self.question=params[:name]
  
  elsif item_type=="0"
            self.number=0
            self.text=params[:name]
  else
      if ( params[:item][:number]==nil )
         errors.add(:number,"choose item number!!!")
         return
      end   
         self.number=params[:item][:number]
         self.question=params[:name]
   end
  
  self.ind=params[:ind]
  self.examination_id=params[:item][:examination_id]
  self.chapter_id = params[:chapter_id]     
  return self.save
end  



def save_params(params,chapter_id)
  item_type=params[:select_type]
  if item_type=="-1"
    self.number=-1
    self.instructions=params[:name]
    self.text=params[:text]
    self.question=nil
elsif  item_type=="-2"
	  self.number=-2
      self.instructions=nil
      self.text=nil
      self.question=params[:name]


  elsif  item_type=="0"
            self.number=0
            self.text=params[:name]
            self.instructions=nil
            self.question=nil
  else
         self.number=params[:number]
         self.question=params[:name]
         self.instructions=nil
         self.text=nil
   end
  
  self.ind=params[:ind]
  self.examination_id=params[:examination_id]
  self.chapter_id = chapter_id     
  return self.save
end  
  
    def parts_number
        parts = 3        
        #find the numbers of parts
         f_name = FILES_ROOT + '/'+ self.chapter.number.to_s + '/'+ self.text+'.6.ogg'
         if File.exists?(f_name)
            parts = 6
         elsif
         f_name = FILES_ROOT + '/'+ self.chapter.number.to_s + '/'+ self.text+'.5.ogg'
         if File.exists?(f_name)
            parts = 5
         elsif
           f_name = FILES_ROOT + '/'+ self.chapter.number.to_s + '/'+ self.text+'.4.ogg'
           if File.exists?(f_name)
             parts = 4
           end 
          end
         end
         parts
    end
       
    def write_to_asx_file(filename, asx_str)
      dir_name = FILES_ROOT + '/'+self.chapter.number.to_s + '/asx/'
      Dir.mkdir(dir_name) unless File.exists?(dir_name)
      asx_file = File.open(dir_name + filename + ".asx" ,"w+")
      asx_file.write(asx_str)      
      asx_file.close   
    end
  
end
