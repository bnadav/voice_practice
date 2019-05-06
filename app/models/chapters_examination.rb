class ChaptersExamination < ActiveRecord::Base
  belongs_to :chapter
  belongs_to :examination

   validates_uniqueness_of :ind, :scope => [:examination_id]
   
   #4attr_accessible :examination_id, :ind
   def number
         chapter.number
   end

   

end
