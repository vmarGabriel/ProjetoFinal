class Api::V2::GainsController < Api::V2::BaseController
    before_action :authenticable_user!
    
    def index
        gains = current_user.gains.ransack(params[:q]).result
        render json: gains, status: 200
    end
    
    def show
        gain = current_user.gains.find(params[:id])
        render json: gain, status: 200
    end
    
    def create
        gain = current_user.gain.build(gain_params)
        if gain.save
            render json: gain, status: 201
        else
            render json: { errors: gain.errors }, status: 422
        end
    end
    
    def update
        gain = current_user.gains.find(params[:id])
        if gain.update_attributes(gain_params)
            render json: gain, status: 200
        else
            render json: { errors: gain.errors }, status: 422
        end
    end
    
    def destroy
        gain = current_user.gains.find(params[:id])
        gain.destroy
        head 204
    end
    
    private
    
    def gain_params
        params.require(:gain).permit(:description, :value, :date)
    end
    
end
