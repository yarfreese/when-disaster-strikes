class PostsController < ApplicationController
  # before_action :require_signin!, except: [:show, :index]
  before_action :require_signin!
  before_action :set_project
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_create!, only: [:new, :create]
  before_action :authorize_update!, only: [:edit, :update]
  before_action :authorize_delete!, only: :destroy

  def new
    @post = @project.posts.build
    # about the same as:
    # Post.new(:project_id => @project.id)
  end

  def create
    @post = @project.posts.build(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post has been created."
      redirect_to [@project, @post]
    else
      flash[:alert] = "Post has not been created."
      render :action => "new"
    end
  end  

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post has been updated."

      redirect_to [@project, @post]
    else
      flash[:alert] = "Post has not been updated."

      render action: "edit"
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Post has been deleted."

    redirect_to @project
  end

private
  def set_project
    @project = Project.for(current_user).find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you were looking " +
                    "for could not be found."
    redirect_to root_path
  end

private
  def set_post
    @post = @project.posts.find(params[:id])
  end

private
  def post_params
    params.require(:post).permit(:title, :description, :asset)
  end

private
  def authorize_create!
   if !current_user.admin?  && cannot?("create posts".to_sym, @project)
     flash[:alert] = "You cannot create posts on this project."
     redirect_to @project
   end 
  end

private
  def authorize_update!
    if !current_user.admin? && cannot?("edit posts".to_sym, @project)
      flash[:alert] = "You cannot edit posts on this project."
      redirect_to @project
    end
  end  

private
  def authorize_delete!
    if !current_user.admin? && cannot?("delete posts".to_sym, @project)
      flash[:alert] = "You cannot delete posts from this project."
      redirect_to @project
    end
  end
end
