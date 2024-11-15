module Api
  module V1
    class Users::RegistrationsController < Devise::RegistrationsController
      include RackSessionsFix

      respond_to :json

      private

      def update_resource(resource, params)
        resource.update_without_password(params)
      end

      def respond_with(current_user, _opts = {})
        if resource.persisted?
          message = I18n.t('api.users.registrations.signed_up_successfully')

          render json: {
            status: {
              code: 200,
              message: request.patch? || request.put? ? I18n.t('api.users.registrations.updated_successfully') : message
            },
            data: UserSerializer.render_as_hash(current_user)
          }
        else
          error_message = I18n.t('api.users.registrations.creation_failed',
                                 errors: current_user.errors.full_messages.to_sentence)

          render json: {
            status: { message: error_message }
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
