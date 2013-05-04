class Text < ActiveRecord::Base
  
  #####################################
  #
  # Relations
  #
  #####################################
  has_many :word_lists
  has_many :words, through: :word_lists
  # has_one   :lang
  belongs_to  :lang

  #####################################
  #
  # Before operations
  #
  #####################################
  # before_save :add_created_at_millsec, add_updated_at_millsec
  before_save :add_created_at_millsec
  before_save :add_updated_at_millsec
  before_update :add_updated_at_millsec
  # before_update :update_created_at_millsec
  
  
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
