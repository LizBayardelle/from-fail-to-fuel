class ApplicationController < ActionController::Base
  
  def admin_only
    unless current_user && current_user.admin
      redirect_to root_path
      flash[:danger] = "Sorry, you have to be an admin to do that.  Come back when your top secret credentials have been issued."
    end
  end

end
