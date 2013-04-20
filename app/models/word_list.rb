class WordList < ActiveRecord::Base
  
  belongs_to :text
  belongs_to :word

end
