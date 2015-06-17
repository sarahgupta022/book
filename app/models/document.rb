class Document < ActiveRecord::Base
  attr_accessible :attachment, :remove_attachment
  has_attached_file :attachment
    do_not_validate_attachment_file_type :attachment                 
   validates_attachment :attachment,
    presence: true,
    context_type: { context_type: %w(image/jpeg image/jpg imag/png image/gif) }
    
  
  attr_accessor :remove_attachment
  
  before_save :perform_attachment_removal
  def perform_attachment_removal
    if remove_attachment == '1' && !attachment.dirty?
      self.attachment = nil
    end
  end
end