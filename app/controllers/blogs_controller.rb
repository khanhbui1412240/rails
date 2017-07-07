class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! , only: [:edit,:new,:destroy,:create,:userblog]
  before_action :set_breadcrum, only:[:new,:userblog]
  before_action :check_user, only:[:edit]

  # GET /blogs
  # GET /blogs.json
  def index
    if user_signed_in?
      redirect_to user_blog_path
    else
      redirect_to root_path
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    if (@blog.status == "private" )
      check_user
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @newblog = "active"
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create

    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id

      respond_to do |format|
        if @blog.save
          format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
          format.json { render :show, status: :created, location: @blog }
        else
          format.html { render :new }
          format.json { render json: @blog.errors, status: :unprocessable_entity }
        end
      end  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to user_blog_path, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def userblog
    @blogs = current_user.blogs
    @myblog ="active"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    def check_user
      if user_signed_in?
        if @blog.user_id.to_i != current_user.id
            redirect_to root_path
        end
      else
          redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
    params.require(:blog).permit(:title, :content,:status,:avatar )
    end
    def set_breadcrum
      @newblog = nil
      @myblog = nil
    end
end
