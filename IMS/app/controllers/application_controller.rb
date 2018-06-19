class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters,if: :devise_controller?
  before_action :notification
    def configure_permitted_parameters
      added_attrs = [:name, :email, :password, :password_confirmation, :birth, :gender, :avatar, :group_id ]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

# def authenticate_admin_user!
#    super
#   #  puts current_admin_user.role
#  raise SecurityError if current_admin_user.role.try(:Instructor)
# end
# def after_sign_in_path_for(admin_user)
#   admin_user.Instructor? ? admin_dashboard_path : root_path 

def notification
  if current_student.present? 
    @notifications = Usernotification.where("student_id = ? AND seen = ?",current_student.id, 0)
    @count_of_notifications = @notifications.count
    puts @count_of_notifications
    puts "ssssssssssssssssssssssss"
  end  
end



    def current_ability
      @current_ability ||= Ability.new(current_student)
    end

    def render_404
      render file: "#{Rails.root}/public/404", status: :not_found
  end
  
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
      
  end
