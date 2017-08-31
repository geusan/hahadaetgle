class HomeController < ApplicationController
  before_action :authorize
  def index
    @author = session[:user_name]
  end

  def list
    @all = Post.all
  end

  def show
    @post = Post.find(params[:id])
    # @replies = Reply.where("postId = #{params[:id]}")
    # @replies = Reply.where(postId: params[:id]) // 다른방법 같은 결과
    @replies = @post.replies
    @myName = session[:user_name]
  end
  
  def write
    newPost = Post.new
    newPost.title = params[:title]
    newPost.content = params[:content]
    newPost.author = params[:author]
    newPost.save
    
    redirect_to "/list"
  end
  
  def reply
    reply = Reply.new
    reply.post_id = params[:post_id]
    reply.author = params[:author]
    reply.content = params[:content]
    reply.save
    
    redirect_to "/show/#{params[:post_id]}"
  end
  
  def modify
    @post = Post.find(params[:id])
  end
  
  def update
    u_post = Post.find(params[:id])
    u_post.title = params[:title]
    u_post.content = params[:content]
    u_post.author = params[:author]
    u_post.save
    
    redirect_to "/show/#{params[:id]}"
  end
  
  def delete
    d_post = Post.find(params[:id])
    d_post.destroy
    
    redirect_to "/"
  end
  
  def reply_delete
    d_reply = Reply.find(params[:reply_id])
    d_reply.destroy
    
    redirect_to "/show/#{params[:post_id]}"
  end
  
end
