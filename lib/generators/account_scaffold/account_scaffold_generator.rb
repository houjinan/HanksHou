require 'rails/generators/resource_helpers'
require "rails/generators/model_helpers"

module Rails
  module Generators
    class AccountScaffoldGenerator < Rails::Generators::NamedBase

      include Rails::Generators::ModelHelpers
      include Rails::Generators::ResourceHelpers
      # remove_hook_for :resource_controller
      # remove_class_option :actions

      check_class_collision suffix: "Controller"

      argument :attributes, type: :array, default: [], banner: "field[:type][:index] field[:type][:index]"

      class_option :disable_common, type: :boolean, default: false, desc: 'SETS: --no-helper --no-view-specs --no-request-specs --no-routing-specs'

      source_root File.expand_path('../templates', __FILE__)

      # def create_model_file
      #   template "model.rb.tt", File.join("app/models", class_path, "#{file_name}.rb")
      # end
      hook_for :orm, :in => :rails, :required => true, :as => :model do |invoked|
        invoke invoked, [singular_name]
      end

      def create_controller_files
        if @options[:disable_common]
          puts 'Project Overrides'
          puts 'Disabling: helpers, view-specs, request-specs, and route-specs'
          @options = @options.merge(helper: false)
        end
        template "controller.rb", File.join('app/controllers', controller_class_path, "#{controller_file_name}_controller.rb")
      end

      hook_for :template_engine, :test_framework, as: :scaffold do |invoked|
        controller_name_param = controller_class_path.blank? ? singular_name : (controller_class_path.join("/") + "/" + singular_name)
        if @options[:disable_common]
          invoke invoked, [ controller_name_param ], {view_specs: false, request_specs: false, routing_specs: false}
        else
          invoke invoked, [ controller_name_param ]
        end
      end

      # Invoke the helper using the controller name (pluralized)
      hook_for :helper, as: :scaffold do |invoked|
        invoke invoked, [ controller_name ]
      end

      hook_for :assets do |assets|
        invoke assets, [controller_name]
      end

      hook_for :resource_route do |route|
        invoke route, [controller_name]
      end

      # hook_for :orm, as: :scaffold do |invoked|
      #   invoke invoked, [class_name]
      # end

    end
  end
end