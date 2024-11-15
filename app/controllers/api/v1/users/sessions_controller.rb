# frozen_string_literal: true

module Api
  module V1
    class Users::SessionsController < Devise::SessionsController
      include RackSessionsFix

      respond_to :json

      private

      def respond_with(current_user, _opts = {})
        message = I18n.t('api.users.sessions.logged_in_successfully')

        render json: {
          status: {
            code: 200,
            message: message,
            data: { user: UserSerializer.render_as_hash(current_user, view: :extended) }
          }
        }, status: :ok
      end

      def respond_to_on_destroy # rubocop:disable Metrics/AbcSize
        if request.headers['Authorization'].present?
          JWT.decode(request.headers['Authorization'].split(' ').last, Rails.env.fetch('DEVISE_JWT_SECRET_KEY')).first
          current_user = User.find(jwt_payload['sub'])
        end

        if current_user
          render json: { status: 200, message: I18n.t('api.users.sessions.logged_out_successfully') }, status: :ok
        else
          render json: { status: 401, message: I18n.t('api.users.sessions.no_active_session') }, status: :unauthorized
        end
      end
    end
  end
end
