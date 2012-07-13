module Invoicera
  class ConfigGenerator < Rails::Generators::Base
    desc "Creates a configuration file at config/initializers/invoicera.rb"

    # Creates a configuration file at <tt>config/initializers/invoicera.rb</tt>
    # when running <tt>rails g invoicera:config</tt>.
    def create_recurly_file
      create_file 'config/initializers/invoicera.rb', <<EOF
Invoicera.api_key          = ENV['INVOICERA_API_KEY']

# Invoicera.default_currency = 'USD'
EOF
    end
  end
end
