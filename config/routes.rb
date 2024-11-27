Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount Rswag::Ui::Engine => '/docs'
      mount Rswag::Api::Engine => '/docs'

      devise_for :users, controllers: { sessions: 'api/v1/users/sessions',
                                        registrations: 'api/v1/users/registrations' }, singular: 'user'

      resources :evaluations, only: %i[index show create] do
        get :result_pdf, on: :member
      end
    end
  end
end
