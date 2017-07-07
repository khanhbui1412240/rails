class HomeController < ApplicationController
  def index
    @blogs = Blog.search(params[:name])
    @home = "active"
    @newblog =nil
    @myblog = nil
  end
end
