module Api
    module V1
        class CommentsController < ApplicationController
            before_action :authorize_access_request!, except: [:index]
            
            def index
                comments = Comment.where(restaurant_id: "#{params[:restaurant_id]}")
                render json: comments.map { |comment|
                    email = User.find(comment.user_id)
                    comment.as_json.merge({ email: email.email })
                  }
            end

            def create
                @comments = Comment.new(comment_params)
                if @comments.save
                    email = User.find(@comments.user_id)
                    render json: @comments.as_json.merge({email: email.email}), status: :created
                  else
                    render json: @comments.errors, status: :unprocessable_entity
                  end
            end

            def comment_params
                params.permit(:comment, :restaurant_id, :user_id)
            end
        end
    end
end
