class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  #attr_protected :username, :password_confirmation, :remember_me, 
                            #:first_name, :last_name, :profile_name, :avatar
  
  attr_accessible  :email, :password, :password_confirmation, :remember_me,
                                :first_name, :last_name, :profile_name, :full_name, :avatar                        
    
  validates :first_name, presence: true
        
  validates :last_name, presence: true
           
  validates :profile_name, presence: true,   
                                 uniqueness: true, 
                                 format: { 
                                   with: /^[a-zA-Z0-9_-]+$/ , 
                                    message: 'Must be formatted correctly.' ,
                                    multiline: true
                                  } 
    has_many :conversations, :foreign_key => :sender_id   
    after_create :create_default_conversation                           
    has_many :activities                                 
    has_many :albums
    has_many :pictures
    has_many :statuses
    has_many :user_friendships
    has_many :friends, -> { where(user_friendships: { state: "accepted"}) }, through: :user_friendships

                       
    has_many :pending_user_friendships, class_name: 'UserFriendship',
                                       foreign_key: :user_id
                                       
                                     
                                       
    has_many :pending_friends, 
              -> { where user_friendships: { state: "pending" } }, 
                 through: :pending_user_friendships,
                 source: :friend  
                 
     has_many :requested_user_friendships, class_name: 'UserFriendship',
                                       foreign_key: :user_id
                                       
                                     
                                       
    has_many :requested_friends, 
              -> { where user_friendships: { state: "requested" } }, 
                 through: :requested_user_friendships,
                 source: :friend  
                 
                              
      has_many :blocked_user_friendships, class_name: 'UserFriendship',
                                       foreign_key: :user_id
                                       
                                     
                                       
    has_many :blocked_friends, 
              -> { where user_friendships: { state: "blocked" } }, 
                 through: :blocked_user_friendships,
                 source: :friend   
                 
     has_many :accepted_user_friendships, class_name: 'UserFriendship',
                                       foreign_key: :user_id
                                       
                                     
                                       
    has_many :accepted_friends, 
              -> { where user_friendships: { state: "accepted" } }, 
                 through: :accepted_user_friendships,
                 source: :friend   
                 
     has_attached_file :avatar, :styles => {
          :thumb    => ['100x100#',  :jpg, :quality => 70],
          :preview  => ['480x480#',  :jpg, :quality => 70],
          :large    => ['800>',      :jpg, :quality => 70],
          :retina   => ['1200>',     :jpg, :quality => 30]
       },
    :convert_options => {
         :thumb    => '-set colorspace sRGB -strip',
         :preview  => '-set colorspace sRGB -strip',
         :large    => '-set colorspace sRGB -strip',
         :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
      } 
                          
             validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
             
             
                                              
          # def default_avatar_feed
              #  "Avatar-default-thumb.jpg"
           #end                
                         
                          
           def self.get_gravatars
             all.each do |user|
                if !user.avatar?
                 user.avatar = URI.parse(user.gravatar_url)
                  user.save
                  print "."
                end
              end
           end  
           
                               
                 
                        
         def full_name
           first_name + " " + last_name
         end 
         
         def to_param
           profile_name
         end
         
         def to_s
           first_name
         end
             
             def gravatar_url
               stripped_email = email.strip
               downcased_email = stripped_email.downcase
               hash = Digest::MD5.hexdigest(downcased_email)
               
               "http://gravatar.com/avatar/#{hash}"
             end  
             
            
             
         def has_blocked?(other_user)
           blocked_friends.include?(other_user)
         end
         
         def create_activity(item, action)
           activity = activities.new
           activity.targetable = item
           activity.action = action
           activity.save
           activity
         end
    
    private
     def create_default_conversation
           Conversation.create(sender_id: 1, recipient_id: self.id) unless self.id == 1
         end 
end