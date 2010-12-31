class Activity < ActiveRecord::Base
  validates :description, :presence => true
  
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :tags
  
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  self.per_page = 5
  
  def description_short
    description.length > 50 ? "#{description[0,50]}..." : description
  end
end
