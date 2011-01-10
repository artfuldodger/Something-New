class Activity < ActiveRecord::Base
  validates :description, :presence => true
  
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :tags
  
  accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  self.per_page = 20
  
  def description_short
    description.length > 100 ? "#{description[0,100]}..." : description
  end
end
