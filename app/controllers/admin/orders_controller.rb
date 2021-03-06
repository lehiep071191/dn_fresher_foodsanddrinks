class Admin::OrdersController < Admin::BaseController
  authorize_resource

  before_action :admin_load_order, only: %i(update)

  def index
    @search = Order.ransack(params[:q])
    @orders = @search.result(distinct: true)
                     .page(params[:page])
                     .per(Settings.page.per_10)
  end

  def update
    status = params[:status].to_i
    if status
      ActiveRecord::Base.transaction do
        @order.update_status status
        # OrderMailer.order_notify(@order).deliver_now
        flash[:success] = t("admin.order.status", status: @order.status)
      end
    else
      flash[:danger] = t "admin.order.update_fail"
    end
    redirect_to admin_orders_path
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t "admin.order.update_fail"
    redirect_to admin_orders_path
  end

  private

  def admin_load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:danger] = t "controllers.orders.not_found"
    redirect_to admin_orders_path
  end
end
