class Admin::UsersController < Admin::BaseController
  def index
  end
end
# class Admin::UsersController < ApplicationController
# switched to BaseController because using admin namespace
# "Because Admin::UsersController now inherits from Admin::BaseController , the before_filter from
# Admin::BaseController now runs for every action inside Admin::UsersController" 
