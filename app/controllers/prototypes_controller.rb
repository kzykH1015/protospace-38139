class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:new, :edit, :destroy]
  before_action :move_index, only: :edit
  before_action :set_prototype, except: [:index, :new, :create]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comments = @prototype.comments
    @comment = Comment.new
  end

  def edit
  end

  def update
    @prototype.update(prototype_params)
    if @prototype.save
      redirect_to prototype_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def move_index
    @prototype = Prototype.find(params[:id])
    if @prototype.user.id != current_user.id
      redirect_to action: :index
    end
  end
end
