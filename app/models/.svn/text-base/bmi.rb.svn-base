class Bmi < ActiveRecord::Base
  validates :race, :presence => true
  validates :gender, :presence => true
  validates :weight_lb, :presence => true
  validates :height_inch, :presence => true
  validates :height_ft, :presence => true
  validates :age, :presence => true
  #validates_length_of :race, :minimal=> 1,:allow_nil => false
  #validates_length_of :gender,:minimal=> 1, :allow_nil => false
  #validates_numericality_of :age, :allow_nil => false
  #validates_numericality_of :weight_lb, :allow_nil => false
  
  GENDER_LIST = [['Select...'],['Male'], ['Female']]
  RACE_LIST = [['White'],['Black'],['Other']]
  ACTIVITY_LEVEL = [['Sedentary'],['Lightly Active'],['Moderately Active'],['Very Active'],['Extra Active']]  
  FEET_LIST = [['4'],['5'],['6']]
  INCH_LIST = [['0'], ['1'],['2'],['3'],['4'],['5'],['6'],['7'],['8'],['9'],['10'],['11']]
  YEAR_LIST = [['1960'], ['1965'], 
               ['1970'],  ['1975'], 
               ['1980'],  ['1985'], 
               ['1990'],  ['1995'], 
               ['2000'],  ['2005'], ['2010']]




  def height
    height_feet*12 + height_inch
  end
  
  
end
