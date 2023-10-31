class PostsController < ApplicationController
    before_action :set_post, only: %i[ show edit update destroy ]
  
    def index
      query = params[:query].to_s.strip
  
      if query.present?
        @posts = Post.where("LOWER(title) LIKE ?", "%#{query.downcase}%")

        Query.new(
          search_query: query,
          ip_address: request.remote_ip,
          views_count: 1
        ).update_or_save!
      else
        @posts = Post.all
      end
  
      if turbo_frame_request?
        render partial: "posts", locals: { posts: @posts }
      else
        render :index
      end
    end
  
    def show
      @post = Post.find(params[:id])
    end
  
    def new
      @post = Post.new
    end
  
    def edit
    end
  
    def create
      @post = Post.new(post_params)
  
      respond_to do |format|
        if @post.save
          format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @post.destroy
  
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    end
    
    
    private
    
      def set_post
        @post = Post.find(params[:id])
      end
  
      def post_params
        params.require(:post).permit(:title, :body)
      end
  end
  