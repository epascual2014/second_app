class CommentsController < ApplicationController

  respond_to :html, :js

  def create
    @topic = Topic.find(params[:topic_id]) #prepare @topic
    @post = Post.find(params[:post_id]) #prepare @post
    @comment = current_user.comments.build(params.require(:comment).permit(:body, :post_id)) #prepare @comments
    @comment.post = @post #bind @comment to @post
    @new_comment = Comment.new
    @comments = @post.comments
    
    authorize! :create, @comment, message: "You need to be signed up to comment." #prepare @comment (bound to user)
    if @comment.save
      flash[:notice] = "Comment has been added." #redirect
      redirect_to [@topic, @post]
    else
      #flash for error
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'post/show'
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment, message: "You need to own the comment to delete it."
    
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment couldn't be deleted. Try again"
      redirect_to [@topic, @post]
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end
end
