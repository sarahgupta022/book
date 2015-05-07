class Status< ActiveRecord::Base
 attr_accessible  :context, :user_id
 belongs_to :user
 
 validates :context, presence: true,
                     length: { minimum: 2}
  
  validates :user_id, presence: true                   
end