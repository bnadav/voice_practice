class Chapter < ActiveRecord::Base
 #4 has_many :items, :dependent => :destroy,:order=>'ind'
  #4 has_many :chapters_examinations, :dependent => :destroy
  #4 has_many :examinations, :through => :chapters_examinations

  has_many :items,->{ order(:ind) },:dependent => :destroy
  has_many :chapters_examinations, :dependent => :destroy
  has_many :examinations, :through => :chapters_examinations
 


   validates_uniqueness_of :number
   validates_presence_of  :number, :name, :lang
  #belongs_to :examination
 #4  attr_accessible :number, :name, :show_formulas, :lang


end
