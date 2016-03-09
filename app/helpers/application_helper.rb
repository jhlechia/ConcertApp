module ApplicationHelper
  def info
    @info = [@current_user, @user, @concert]
  end
end
