class Status< ActiveRecord::Base
 attr_accessible  :context, :document_attributes, :avatar
 belongs_to :user
 belongs_to :document
 
 
  accepts_nested_attributes_for :document
 
 validates :context, presence: true,
                     length: { minimum: 2}
  
  validates :user_id, presence: true  
  
  
                 
end