class ItemsController < ApplicationController

  # add before action
  def index
    @items = Item.all
  end

  def create
    @item = Item.new(item_params)
    @item.status = 0
    if @item.save
      redirect_to items_path, notice: 'Item Report Submitted'
    else
      # render :new
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
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_parans)
      redirect_to items_path, notice: "Item succcesfully updated"
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :name, :status, :date, :reward, :location, :description)
  end
end
