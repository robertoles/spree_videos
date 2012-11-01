module Spree
  class Video < ActiveRecord::Base
    belongs_to :owner, touch: true, polymorphic: true

    attr_accessible :reference, :url, :title, :hebergeur, :owner_id
    validates_presence_of :hebergeur
    validates :url, :presence => true
    validates_uniqueness_of :reference , :scope => [:owner_id, :owner_type]

    after_validation do
      if m = url.match(/(?:v=|\/)([\w-]+)(&.+)?$/)
        self.reference = m[1]
        self.hebergeur = "youtube"
      end
      if m = url.match(/(?:\/video\/|\/Dailymotion#video=)([^_]+)(.*)$/)
        self.reference = m[1]
        self.hebergeur = "dailymotion"
      end
      if m = url.match(/(?:vimeo.com\/)(?:channels\/)?(?:[\w]+\/)?([0-9]+)$/)
        self.reference = m[1]
        self.hebergeur = "vimeo"
      end
      video = VideoInfo.new(self.url)
      self.title = video.title
    end
  end
end