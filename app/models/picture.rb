class Picture < ActiveRecord::Base
  belongs_to :album
  belongs_to :user
  attr_accessible :caption, :description, :asset
  
  has_attached_file :asset, style: { 
                          large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#"
                          }
                          
                                
                          
    validates_attachment :asset, content_type: { content_type: /\Aimage\/.*\Z/ }

      validates_attachment_file_name :asset, :matches => [/png\Z/, /jpe?g\Z/]
     

     
                          
      def to_s
        caption? ? caption : "Picture"
      end                    
end
