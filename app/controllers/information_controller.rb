class InformationController < ApplicationController
  def index
    @information = Weather.all
  end

  def show
  end
end
