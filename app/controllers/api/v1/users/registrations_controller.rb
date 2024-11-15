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
          message = request.patch? || request.put? ? 'Updated successfully.' : 'Signed up successfully.'

          render json: {
            status: { code: 200, message: message },
            data: UserSerializer.render_as_hash(current_user, view: :extended)
          }
        else
          render json: {
            status: {
              message: "User couldn't be created successfully. #{current_user.errors.full_messages.to_sentence}"
            }
          }, status: :unprocessable_entity
        end
      end
    end
  end
end
