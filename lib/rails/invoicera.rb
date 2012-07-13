module Invoicera
  class Railtie < Rails::Railtie
    initializer :invoicera_set_logger do
      Invoicera.logger = Rails.logger
    end

    initializer :invoicera_set_accept_language do
      ActionController::Base.prepend_before_filter do
        Invoicera::API.accept_language = request.env['HTTP_ACCEPT_LANGUAGE']
      end
    end
  end
end
