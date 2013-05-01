class WordList < ActiveRecord::Base
  
  #####################################
  #
  # Relations
  #
  #####################################
  belongs_to :text
  belongs_to :word

  #####################################
  #
  # Before operations
  #
  #####################################
  # => http://stackoverflow.com/questions/6584745/processing-data-before-saving-to-database
  before_save :add_created_at_millsec
  before_save :add_updated_at_millsec

  before_update :add_updated_at_millsec
  # before_update :update_created_at_millsec
  #####################################
  #
  # Validations
  #
  #####################################
  # validates_uniqueness_of :text_id, :scope => :word_id
  
  #####################################
  #
  # Methods
  #
  #####################################  
  protected
  def add_created_at_millsec
    
    mill_sec = (Time.now.to_f * 1000.0).to_i
    
    self.created_at_mill = mill_sec
    self.updated_at_mill = mill_sec
    
    # self.created_at_mill = (Time.now.to_f * 1000.0).to_i
    
  end#def add_created_at_millsec
  
  def add_updated_at_millsec
  # def update_created_at_millsec
    
    mill_sec = (Time.now.to_f * 1000.0).to_i
    
    self.updated_at_mill = mill_sec
    
  end#def update_created_at_millsec
  
end
