require 'streamio-ffmpeg'
 module VideoScreenshot
   def convert_to_jpg
     movie = FFMPEG::Movie.new("#{Rails.root}/public#{self.video_url}")
     movie.duration
     movie.screenshot("#{Rails.root}#{self.id}_screenshot.jpg",seek_time: 5, resolution: '200x100')
    self.image = File.open("#{Rails.root}#{self.id}_screenshot.jpg")
    self.save!
   end
 end 