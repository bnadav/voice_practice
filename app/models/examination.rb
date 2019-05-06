class Examination < ActiveRecord::Base
 #4 has_many :chapters_examinations, :order => 'ind', :include => 'chapter'
#4  has_many :chapters, :through => :chapters_examinations,  :order => 'chapters_examinations.ind'
   
 has_many :chapters_examinations, -> {includes( :chapter).order(:ind) }, :dependent => :destroy
 has_many :chapters, -> {order('chapters_examinations.ind')}, through: :chapters_examinations	
 

  has_many :items
  
   #attr_accessible  :name, :instruction, :lang, :exam_type
  validates_presence_of :exam_type, :name
  
def practice_exam?
  number==0
end  
  
  
  
def self.find_practice_exam(lang,exam_type)
 # logger.info("Lang=#{lang}")
 
   self.find_by_number_and_lang_and_exam_type(0, lang,exam_type)
  #4 self.where(number: 0, lang: lang, exam_type: exam_type)
end  

end
