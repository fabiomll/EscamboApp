class Site::HomeController < SiteController


  def index
    #@categories = Category.all.order(:description)
    @categories = Category.order_by_description
    #@ads = Ad.limit(6).order(created_at: :desc)
    #@ads = Ad.last_six
    @ads = Ad.descending_order(params[:page])
    @carousel = Ad.random(3)
  end
end
