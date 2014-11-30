class VideosController < ApplicationController
   before_filter :authenticate_user!
	def index
		
   
    @fetch_videos = Video.fetch_videos(current_user,'Public')
   
    #@index_videos = (@videos + @fetch_videos)
		@users = User.all
	end

	def new
		@video = Video.new
		@users = User.all
	end

	def create
   
    params[:video] = params[:video].merge(user_id: current_user.id)

		@video = Video.new(video_params)
    current_user.videos << @video
    
		if @video.save
       redirect_to videos_path ,:notice => "Saved successfully"

		else
      flash.now.alert = " #{@video.errors.full_messages.join(",")}" if @video.errors.any?
			render('new') 
		end
	end
	
  def show

  	@video = Video.find(params[:id])
  	@analytics = Analytic.where(video_id: @video.id,user_id: current_user.id).last
    @count = Video.fetch_seen_count(@video.id , true)
    @videos = current_user.videos
    @fetch_videos = Video.fetch_videos(current_user,'public')
    @comments = @video.comments
    @comment = @video.comments.new
    #binding.pry
    
  end

  
  def destroy
  	@video = Video.find(params[:id])
  	if @video.destroy
  		redirect_to videos_path ,:notice => "Destroy successfully"
  	end
  end

  def like_video
  	@video = Video.find(params[:id])
  	Video.like_status(@video.id , current_user)
   	redirect_to video_path    
  end

  def seen_video
  	@video = Video.find(params[:id])
  	Video.seen_status(@video.id , current_user)

    respond_to do |format|
          format.html {
             redirect_to video_path 
           }

           format.js{
            render json: { success: true}
           }
        end 
  end

  def share_video_with_user
    #binding.pry
    @video = Video.find(params[:id])
    @users = User.find(params[:user])
    @users.each do |user|
      @video.users << user
    end
     redirect_to video_path(@video)
    
  end

  private
	def video_params
    params.require(:video).permit(:title, :description, :video ,:user_id ,:video_type,:like_count ,:videos_screenshot)
  end

  def analytics_params
  	params.require(:analytics).permit(:user_id ,:video_id,:like,:seen)
  end

end
