class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @workouts = current_user.workouts
  end
end
