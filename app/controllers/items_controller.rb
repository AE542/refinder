class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  def index
    @items = policy_scope(Item).order(date: :asc).all
    @lost_marker_items = policy_scope(Item).order(date: :asc).where(status: 0)
    @markers = @lost_marker_items.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        status: item.status,
        info_window_html: render_to_string(partial: "shared/info_window", locals: { item: }),
        marker_html: render_to_string(partial: "marker", locals: { item: })
      }
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
      redirect_to item_path(@item), notice: 'Showing Possible matches.'
    else
      render :new
    end
  end

  def show
    authorize @item
    @marker = {
      lat: @item.latitude,
      lng: @item.longitude
    }
    # Initialize @potential_matches
    @potential_matches = []
    # Find potential matches within 3 km distance
    @potential_matches = Item.near([@item.latitude, @item.longitude], 30000, units: :mi)
                         .where.not(user_id: current_user.id)


    @markers = @potential_matches.geocoded.map do |item|
      {
        lat: item.latitude,
        lng: item.longitude,
        status: item.status,
        info_window_html: render_to_string(partial: "shared/info_window", locals: { item: }),
        marker_html: render_to_string(partial: "marker", locals: { item: })
      }
    end
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
    redirect_to my_items_path, notice: 'Item deleted successfully.'
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
