class Lang < ActiveRecord::Base

  #####################################
  #
  # Validations
  #
  #####################################
  validates :name, uniqueness: true
  
  # REF presence 黒田・佐藤 237
  validates :name, presence: true

  #####################################
  #
  # Relations
  #
  #####################################
  has_many :word_lists
  has_many :words
  has_many :texts
  # belongs_to :word_lists
  # belongs_to :words
  # belongs_to :texts

  #####################################
  #
  # Before operations
  #
  #####################################
  before_save :add_created_at_millsec
  before_save :add_updated_at_millsec
  before_update :add_updated_at_millsec

  #####################################
  #
  # Methods
  #
  #####################################
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
