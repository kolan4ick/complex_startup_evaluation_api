# frozen_string_literal: true

module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      include RackSessionsFix

      respond_to :json

      private

      def respond_with(current_user, _opts = {})
        render json: {
          status: {
            code: 200, message: 'Logged in successfully.',
            data: { user: UserSerializer.render_as_hash(current_user) }
          }
        }, status: :ok
      end

      def respond_to_on_destroy # rubocop:disable Metrics/AbcSize
        if request.headers['Authorization'].present?
          JWT.decode(request.headers['Authorization'].split(' ').last,
                     Rails.application.credentials.devise_jwt_secret_key!).first
          current_user = User.find(jwt_payload['sub'])
        end

        if current_user
          render json: {
            status: 200,
            message: 'Logged out successfully.'
          }, status: :ok
        else
          render json: {
            status: 401,
            message: "Couldn't find an active session."
          }, status: :unauthorized
        end
      end
    end
  end
end
