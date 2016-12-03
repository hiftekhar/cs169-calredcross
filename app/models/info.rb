class Info < ApplicationRecord
    has_many :home_images, :dependent => :destroy
    has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing_ava.png"
    validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

    
    def update_bulletin(text)
        self.update_attribute(:bulletin, text)
    end
    
    def update_motm_name(name)
        self.update_attribute(:name, name)
    end
    
    def update_motm_comments(comments)
        self.update_attribute(:comments, comments)
    end
    
    def update_motm_avatar(avatar)
        File.open("avatar", 'wb') do |f|
      f.write avatar
      self.update_attribute(:avatar, f)
    end
    
  end
end
