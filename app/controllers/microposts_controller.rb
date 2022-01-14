class MicropostsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create, :inquire_enterprise]
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    # Use the built-in with_attached_images scope to avoid N+1
    # @micropost = Micropost.all.with_attached_images
  end

  def create
    @micropost = current_user.microposts.new(micropost_params)

    # @micropost.update(params[:images])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  private

  def micropost_params
    params.require(:micropost).permit(:content, {images: []})
  end


  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
