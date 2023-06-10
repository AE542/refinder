class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  def index
    @items = policy_scope(Item).all
    if params[:query].present?
      sql_subquery = "name ILIKE :query OR location ILIKE :query"
      @items = @items.where(sql_subquery, query: "%#{params[:query]}%")
    end
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    authorize @item

    if @item.save
      redirect_to root_path, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def show
    authorize @item
  end

  def edit
    authorize @item
  end

  def update
    authorize @item
    if @item.update(item_params)
      redirect_to my_items_path, notice: "Item was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @item
    @item.destroy
    redirect_to items_path, notice: 'Item deleted successfully.'
  end

  def my_items
    @items = policy_scope(Item).where(user: current_user)
  end

  private


  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:user_id, :status, :name, :date, :location, :reward, :description, :image)
  end



end
