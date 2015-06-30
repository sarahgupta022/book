class Document < ActiveRecord::Base
  attr_accessible :attachment, :remove_attachment
  has_attached_file :attachment, style: { 
                          large: "800x800>", medium: "300x200>", small: "260x180>", thumb: "80x80#"
                          } 
                   
   validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
   validates :attachment, attachment_presence: true
    
  
   attr_accessor :remove_attachment
  
   before_save :perform_attachment_removal
   def perform_attachment_removal
     if remove_attachment == '1' && !attachment.dirty?
       self.attachment = nil
     end
   end
 end