class PhotosController < ApplicationController
  def create
    # 浮动窗口上传
    @photo = Photo.new
    @photo.image = params[:file]
    if @photo.image.blank?
      render json: { ok: false }, status: 400
      return
    end
    @photo.user_id = current_user.id
    if @photo.save
      render json: { ok: true, url: @photo.image.url }
    else
      render json: { ok: false }
    end
  end
end
