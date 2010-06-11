class Profile < ActiveRecord::Base
  
  # Make sure facebook id is present, unique and a number
  validates :facebook_id, :presence => true, :uniqueness => true, :numericality => true
end
