class Admin::FlagsController < AdminController
  before_action :find_flag, only: [:edit, :update, :destroy]

  def index
    @flags = Flag.all.order('created_at DESC')
  end

  def edit
  end

  def update
    if @flag.update(flag_params)
      redirect_to admin_flags_path, flash: {success: 'Flag was succesfully updated!'}
    else
      render :edit
    end
  end

  def destroy
		respond_to do |format|
			if @flag.destroy
				format.json {render json: {success: true}}
			else
				format.json {render json: {success: false, errors: @flag.errors}}
			end
		end
	end


  private

  def find_flag
    @flag = Flag.find(params[:id])
  end

  def flag_params
		params.require(:flag).permit(:flag_type_id, :comment, :status)
	end
end
