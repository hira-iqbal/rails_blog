class RolesController < ApplicationController

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to @role, notice: "Role is saved successfully."
    else
      render :new, alert: @role.errors.full_messages
    end
  end

  def new
    @role = Role.new
  end


  def role_params
    params.require(:role).permit(:name)
  end
end
