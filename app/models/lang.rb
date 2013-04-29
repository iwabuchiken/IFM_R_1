class Lang < ActiveRecord::Base
  
  validates :name, uniqueness: true
  
  # REF presence 黒田・佐藤 237
  validates :name, presence: true
  
  has_many :word_lists
  has_many :words
  has_many :texts
  # belongs_to :word_lists
  # belongs_to :words
  # belongs_to :texts
  
end
