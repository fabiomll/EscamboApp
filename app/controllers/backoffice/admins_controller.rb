class Backoffice::AdminsController < BackofficeController
  before_action :set_admin, only: [:edit, :update, :destroy]

   after_action :verify_authorized, only: [:new, :destroy]
   after_action :verify_policy_scoped, only: :index


  def index
    #@admin = Admin.all
    @admin = policy_scope(Admin)
  end

  def new
    @admin = Admin.new
    authorize @admin
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to backoffice_admins_path, notice: "O administrador (#{@admin.email}) foi cadastrado com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    authorize @admin
    admin_email = @admin.email

    if @admin.destroy
      redirect_to backoffice_admins_path, notice: "O administrador (#{admin_email}) foi excluído com sucesso!"
    else
      render index
    end
  end

  def update
    passwd = params[:admin][:password]
    password_confirmation = params[:admin][:password_confirmation]

    if passwd.blank? && password_confirmation.blank?
      params[:admin].delete(:password)
      params[:admin].delete(:password_confirmation)
    end

    if @admin.update(params_admin)
      AdminMailer.update_email(current_admin, @admin).deliver_now
      redirect_to backoffice_admins_path, notice: "O administrador (#{@admin.email}) foi atualizado com sucesso!"
    else
      render :edit
    end
  end


  private

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def params_admin
      #params.require(:admin).permit(:name, :email, :role, :password, :password_confirmation)

      if @admin.blank?
        params.require(:admin).permit(:name, :email, :role, :password, :password_confirmation)
      else
        params.require(:admin).permit(policy(@admin).permitted_attributes)
      end


    end
end
