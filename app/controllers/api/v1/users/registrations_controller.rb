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
        if resource.persisted? && resource.errors.empty?
          render json: { user: UserSerializer.render_as_hash(current_user) }
        else
          error_message = generate_error_message
          render json: { message: error_message }, status: :unprocessable_entity
        end
      end

      def generate_error_message
        key = case action_name
              when 'create' then 'creation_failed'
              when 'update' then 'update_failed'
              else 'generic_error'
              end

        I18n.t("api.users.registrations.#{key}", errors: resource.errors.full_messages.to_sentence)
      end
    end
  end
end
