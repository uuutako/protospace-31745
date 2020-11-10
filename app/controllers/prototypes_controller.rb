class PrototypesController < ApplicationController

  before_action :move_to_index, except: [:index, :show, :edit]
  
  def index
    @prototype = Prototype.all
    @prototypes = @prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new #form_withというヘルパーメソッドを使用しますが、その際にこのインスタンス変数が必要となるため
  end

  def create
    @prototype = Prototype.new(prototype_params)  
    if @prototype.save
       redirect_to root_path(@prototype)
    else
      @prototype = @prototype.includes(:user)
       render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id]) 
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
      if prototype.update(prototype_params)
        redirect_to prototype_path(prototype_params)
      else
        render :edit
      end
  end
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path(@prototype)
  end

  private
  def prototype_params
      params.require(:prototype).permit(:title, :catch_copy , :concept, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
     redirect_to action: :index
    end
  end

end