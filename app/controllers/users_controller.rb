class UsersController < ApplicationController
  def index
    @users = User.all
    @relationship = Relationship.new
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
  end
end
