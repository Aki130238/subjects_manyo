module ApplicationHelper
  def admin?
    current_user.admin.present?
  end
end
