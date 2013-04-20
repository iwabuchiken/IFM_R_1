class WordList < ActiveRecord::Base
  
  belongs_to :text
  belongs_to :word

  # => http://stackoverflow.com/questions/6584745/processing-data-before-saving-to-database
  before_save :add_created_at_millsec
  
  
  protected
  def add_created_at_millsec
    
    self.created_at_mill = (Time.now.to_f * 1000.0).to_i
    
  end#def add_created_at_millsec
end
