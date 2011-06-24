require 'generators/nifty'

module Nifty
  module Generators
    class LayoutGenerator < Base
      argument :layout_name, :type => :string, :default => 'application', :banner => 'layout_name'

      class_option :haml, :desc => 'Generate HAML for view, and SASS for stylesheet.', :type => :boolean
      class_option :saas, :desc => 'Generate SASS for stylesheet.', :type => :boolean

      def create_layout
        if options.haml?
          template 'layout.html.haml', "app/views/layouts/#{file_name}.html.haml"
        else
          template 'layout.html.erb', "app/views/layouts/#{file_name}.html.erb"
        end
        if options.saas? || options.haml?
          copy_file 'stylesheet.sass', "app/assets/stylesheets/#{stylesheet_name}.css.sass"
        else
          copy_file 'stylesheet.css', "app/assets/stylesheets/#{stylesheet_name}.css"
        end
        copy_file 'layout_helper.rb', 'app/helpers/layout_helper.rb'
        copy_file 'error_messages_helper.rb', 'app/helpers/error_messages_helper.rb'
      end

      private

      def file_name
        layout_name.underscore
      end

      # don't overwrite manifest file application.css
      def stylesheet_name
        file_name == 'application' ? 'application-wide' : file_name
      end
    end
  end
end
