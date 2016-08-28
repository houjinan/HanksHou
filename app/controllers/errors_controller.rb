class ErrorsController < ApplicationController
  
  def errors404
  end


  def errors422

  end

  def errors500
    respond_to do |format|
      format.html{}
      format.json{render :text => "errors500"}
    end
  end

end