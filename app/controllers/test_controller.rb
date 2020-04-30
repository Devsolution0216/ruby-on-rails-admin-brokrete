class TestController < ApplicationController
  def index
    render json: { status: "OK" }
  end
end
