class Text < ActiveRecord::Base
  
  has_many :word_lists
  has_many :words, through: :word_lists

end
