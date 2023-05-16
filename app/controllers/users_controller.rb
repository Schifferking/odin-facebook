class UsersController < ApplicationController
  require 'digest/md5'

  def index
    @users = User.all
    @relationship = Relationship.new
  end

  def show
    @user = User.find(params[:id])
    @relationship = Relationship.new
    @user_photo_url = compile_user_photo(@user.email.downcase)
  end

  private

  def compile_user_photo(email)
    "https://www.gravatar.com/avatar/#{create_hash(email)}"
  end

  def create_hash(email)
    Digest::MD5.hexdigest(email)
  end
end
