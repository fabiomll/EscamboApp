class BackofficeController < ApplicationController
  before_action :authenticate_admin!
  layout "backoffice"

  def pundit_user
  #User.find_by_other_means
  current_admin
  end
  
end
