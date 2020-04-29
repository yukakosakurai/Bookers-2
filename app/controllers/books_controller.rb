class BooksController < ApplicationController
  before_action :authenticate_user!
  #before_action :currect_user, only: [:edit, :update]
  
  def index
    @user=current_user #どのページでもログインしているユーザーを表示したい
    @book=Book.new
    @books=Book.all.order(created_at: :desc)
  end

  def show
    @book=Book.find(params[:id])
    @user=@book.user
  end


  def create
    @user=current_user
    @books=Book.all
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully"
      redirect_to book_path(@book)
    else
      render 'books/index'
    end
  end

  def edit
    @book=Book.find(params[:id])
    if current_user.id!=@book.user_id
      redirect_to books_path
    end
  end

  def update
    @book=Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully"
      redirect_to book_path
    else
      render action: :edit
    end
  end

  def destroy
    book=Book.find(params[:id]) 
    book.destroy 
    redirect_to books_path
  end


  private
  def book_params
  params.require(:book).permit(:title, :body, :user_id)
  end
  
end

