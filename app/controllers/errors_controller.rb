class ErrorsController < ApplicationController
  def not_found
    render status: 404
  end

  def not_accessible; end
end
