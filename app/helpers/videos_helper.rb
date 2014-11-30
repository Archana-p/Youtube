module VideosHelper
	 def edit_like_button
    if @analytics.try(:like) == true
    	 return 'unlike'
    else
    	  return 'like'
    end
	 end
end
