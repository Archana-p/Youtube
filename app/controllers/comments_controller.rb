class CommentsController < ApplicationController
	def index
		@comments = Comment.all
	end
	def create
		@video = Video.find(params[:video_id])
   @comment = @video.comments.new(comment_params)
	 
	   if @comment.save 
	   	
	    redirect_to video_path(@video)
	   else
	   	@comments = @video.comments
	   	render template: '/videos/show'
	   end
	end

	def destroy
		@video = Video.find(params[:video_id])
    @comment = Comment.find(params[:id])
   	@comment.destroy
   	redirect_to article_path(@video)
	end 


	private
	def comment_params
    params.require(:comment).permit(:comment,:video_id , :user_id)
  end
end
