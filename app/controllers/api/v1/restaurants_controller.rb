module Api
  module V1
    class RestaurantsController < ApplicationController
      before_action :authorize_access_request!, except: [:show, :index, :search]
      before_action :set_restaurant, only: [:show, :update, :destroy]

      def index
        restaurants = Restaurant.all
        render json: restaurants.map { |restaurant|
              if restaurant.photo.attached?
                restaurant.as_json.merge({ image: rails_blob_url(restaurant.photo, only_path: true) })
              end
        }
      end
      
      def show
        restaurant = Restaurant.find(params[:id])
          if restaurant.photo.attached?
          photo = rails_blob_url(restaurant.photo, only_path: true)
            render json: {image: photo, restorant: restaurant}
          end
      end
      
      def create
        @restaurant = Restaurant.new(restaurant_params)
        if @restaurant.save
          render json: @restaurant, status: :created
        else
          render json: @restaurant.errors, status: :unprocessable_entity
        end
      end

      def search
        if params[:search].blank?
          @restaurant = Restaurant.all
          render json: @restaurant
        else
          @restaurant = Restaurant.search(params)
          render json: @restaurant
        end
      end

      private

        def set_restaurant
          @restaurant = Restaurant.find(params[:id])
        end
        
        def restaurant_params
          params.permit(:nom_restaurant, :prix, :adress, :photo, :speciality, :users_id)
        end
    end
  end
end