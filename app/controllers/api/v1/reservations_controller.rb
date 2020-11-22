module Api
  module V1
    class ReservationsController < ApplicationController
      before_action :authorize_access_request!, except: [:index]
      before_action :set_reservation, only: [:show, :update, :destroy]

        def index
            @reserveds = Reserved.where(restaurant_id: "#{params[:restaurant_id]}")
            render json: @reserveds
        end

        def create
          @reserveds = Reserved.new(reserved_params)
            if @reserveds.save
                @restaurant = Restaurant.find(params[:restaurant_id])
                @user = User.where(id: @restaurant.users_id)
                email = @user.flat_map(&:email)
                ReservationMailer.with(reservation: @reserveds, email: email).new_reservation_email.deliver_later
                render json: @reserveds, status: :created
            else
              render json: @reserveds.errors, status: :unprocessable_entity
            end
        end

        def update
          if @reserveds.update(reserved_params)
            render json: @reserveds
          else
            render json: @reserveds.errors, status: :unprocessable_entity
          end
        end

        def destroy
          @reserveds = Reserved.find(params[:id])
          @reserveds.destroy
          render json: {reservation: @reserveds}, status: :ok
        end

        private

        def set_reservation
          @reserveds = Reserved.find(params[:id])
        end

        def reserved_params
          params.permit(:reservation, :user_email, :users_id, :restaurant_id)
        end
        
    end
  end
end
