class ItemsController < ApplicationController
  before_action :set_hash, only: [:new, :create ,:edit ,:update]
  before_action :item_find_params, only: [:show, :destroy, :edit, :update]


  def index
    @items = Item.all.includes(:images).order("created_at ASC").limit(4)
  end

  def purchase
  end

  def show
  end

 
  def new
    @item = Item.new
    @item.images.new
  end

  def create
    
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @category = Category.find(@item.category_id)
    @conditions = Condition.find(@item.condition_id)
    @delivery_fees = DeliveryFee.find(@item.delivery_fee_id)
    @delivery_methods = DeliveryMethod.find(@item.delivery_method_id)
    @prefectures = Prefecture.find(@item.prefecture_id)
    @days = Day.find(@item.day_id)
  end
  
  def destroy
    if @item.user.id == current_user.id && @item.destroy
      redirect_to root_path, notice: "削除が完了しました"
    else
      redirect_to root_path, alert: "削除が失敗しました"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end


  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end





  private
  def set_hash
    @conditions = Condition.all
    @delivery_fees = DeliveryFee.all
    @delivery_methods = DeliveryMethod.all
    @prefectures = Prefecture.all
    @days = Day.all
  end

  def item_params
    params.require(:item).permit(:name, :explanation, :category_id, :brand, :size, :condition_id, :delivery_fee_id, :prefecture_id, :day_id, :delivery_method_id, :price, images_attributes: [:image, :id])
  end

  def item_find_params
    @item = Item.find(params[:id]) 
  end

end
