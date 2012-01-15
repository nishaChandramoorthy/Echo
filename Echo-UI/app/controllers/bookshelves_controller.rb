class BookshelvesController < ApplicationController
  def index
    @user = User.only(:bookshelves).find_by_user_id(params[:user_d])
    @bookshelves = @user.bookshelves[0, 6]
    @result = Array.new
    @bookshelves.each do |bookshelf|
       temp = Hash.new
       temp["name"] = bookshelf.name
       temp["books"] = Book.only(:book_id, :title, :subtitle, :description, :image_small).where(:book_id.in => bookshelf.book_ids)
       @result << temp
    end
    
    respond_to do |format|
      format.json { render :json => @result }
    end
  end

  def create
    bookshelf = Bookshelf.create(:bookshelf_id => UUID.new, :name => params[:name])
    user = User.only(:bookshelves).find_by_user_id(params[:user_id])
    user.bookshelves << bookshelf
    user.save!

    respond_to do |format|
      format.json { render :json => bookshelf }
    end
  end

  def new
    bookshelf = Bookshelf.create(:bookshelf_id => UUID.new, :name => params[:name])
    user = User.only(:bookshelves).find_by_user_id(params[:user_id])
    user.bookshelves << bookshelf
    user.save!

    respond_to do |format|
      format.json { render :json => bookshelf }
    end
  end

  def edit
     
  end

  def show
    @user = User.only(:bookshelves).find_by_user_id(params[:user_d])
    @bookshelves = @user.bookshelves
    @result = Array.new
    @bookshelves.each do |bookshelf|
       temp = Hash.new
       temp["name"] = bookshelf.name
       temp["books"] = Book.only(:book_id, :title, :subtitle, :description, :image_small).where(:book_id.in => bookshelf.book_ids)
       @result << temp
    end
    
    respond_to do |format|
      format.json { render :json => @result }
    end

  end
  
  def update 
    user = User.only(:bookshelves).find_by_user_id(params[:user_id]) 
    bookshelf = user.bookshelves.where(bookshelf_id: params[:id])
    bookshelf.push(params[:book_id])
    bookshelf.name = params[:name]
    bookshelf.save!
    user.save!
  end

  def destroy
    user = User.only(:bookshelves).find_by_user_id(params[:user_id]) 
    user.bookshelves.where(bookshelf_id: params[:id]).delete_all
  end

  def next

  end

end
