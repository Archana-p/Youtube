class Video < ActiveRecord::Base

	 mount_uploader :video, VideoUploader
	 mount_uploader :image , ImageUploader
	 belongs_to :user
	 has_many :analytics
	 has_many :comments
	 has_many :user_videos
	 has_many :users ,:through => :user_videos
	 validates_presence_of :title , :description 

	 include VideoScreenshot
	 after_create :save_video_screenshot

	def self.like_status(video_id , user)
	 		@analytics = fetch_analytic(video_id ,user)
  	if @analytics.present?
  		@analytics.update_attributes(like: !@analytics.like)
  	else
  		@analytics = create_analytic(user , video_id)
  	end
    v = Video.find(video_id)
  	v.like_count_update
	end
  
  def like_count_update
  	self.update_attributes(like_count: self.fetch_like_count )
  end

	def self.seen_status(video_id , user)
		
		@analytics = fetch_analytic(video_id ,user)
		if @analytics.present?
		  
			 @analytics.update_attributes(seen: true) unless @analytics.seen
		
		else
			@analytics = create_analytic( user , video_id , false,true)
		end
	end

	def self.fetch_videos(current_user , video_type = 'Public')
	  Video.where('video_type = ? AND user_id <> ?', video_type, current_user.id ) + current_user.videos
	end

  def self.fetch_seen_count(video_id , seen = true)
    Analytic.where(video_id: video_id , seen: seen).count
  end

	def self.fetch_analytic(video_id ,user)
		Analytic.where(video_id: video_id,user_id: user.id).last
	end
  
  def self.create_analytic(user , video_id , like = true , seen = false)
  	Analytic.create(user_id: user.id,video_id: video_id ,seen: seen , like: like)
  end

  def fetch_like_count
  	self.analytics.where(like: true).count
  end

	def save_video_screenshot
	
  	convert_to_jpg()
  end 

end
