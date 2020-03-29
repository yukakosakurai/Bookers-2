class UsersController < ApplicationController
  before_action :authenticate_user!
  #before_action :correct_user, only: [:edit, :update]
  def top
  end

  def index
    @users=User.all.order(created_at: :desc)
    @user=current_user
    @book=Book.new
  end

  def show
    @user=User.find(params[:id])
    @book=Book.new
    @books=@user.books
  end

  def new
    @user=current_user
    @book=Book.new
  end


  def edit
    @user=User.find(params[:id])
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully"
      redirect_to user_path
    else
      render 'users/edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
    
end
