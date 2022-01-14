class MicropostImageController < ApplicationController
  before_action :set_micropost

  def create
    add_more_images(images_params[:images])
    flash[:error] = "Failed uploading images" unless @micropost.save
    redirect_to :back
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @micropost.save
    redirect_to :back
  end
  
  private

  def set_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end

  def add_more_images(new_images)
    images = @micropost.images
    images += new_images
    @micropost.images = images
  end

  def remove_image_at_index(index)
    remain_images = @micropost.images
    if index == 0 && @micropost.images.size == 1
      @micropost.remove_images!
    else
      deleted_image = remain_images.delete_at(index)
      deleted_image.try(:remove!)
      @micropost.images = remain_images
    end
  end

  def images_params
    params.require(:micropost).permit({images: []}) # allow nested params as array
  end
end
