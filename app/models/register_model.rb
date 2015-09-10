class RegisterModel < ActiveRecord::Base

  has_attached_file :document, preserve_files: "true",
			:keep_old_files => true,
			:url => "/system/:class/:attachment/:basename_v:version.:extension",
    		:path => ":rails_root/public/system/:class/:attachment/:basename_v:version.:extension"

  has_paper_trail :only => [:document]

  validates :name, presence: true, uniqueness: true
  
  validates_attachment :document, presence: true, 
                                  content_type: {content_type: [
                                  	    "application/msword", 
                                  	    "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
                                  	    ]}
                                  
  validates_attachment_file_name :document, matches: [/docx?\Z/]
  

  Paperclip.interpolates :version do |attachment, style|
  	attachment.instance.versions.last.id.to_s
  end

end
