class ItemsController < ApplicationController

  # add before action
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(items_params)
    if @item.save
      redirect_to items_path, notice: 'Item Report Submitted'
    else
      render :new
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item.find(params[:id])
  end


  # add remaining methods below

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def items_params
    params.require(:item).permit(:user_id, :name, :status, :date, :reward, :location, :description)
  end

end
