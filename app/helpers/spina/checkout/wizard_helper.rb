module Spina
  module Checkout
    module WizardHelper

      def loading_gif
        image_tag("spina/checkout/loading.gif", width: 24)
      end
      
      def product_image_tag(orderable, variant_options = {}, html_options = {})
        image = get_first_product_image(orderable)
        if image && image.file.attached?
          image_tag main_app.url_for(image.file.variant(variant_options)), html_options
        end
      end

      def checkout_field(form_builder, name, options = {})
        value = options[:value] || form_builder.object.send(name) || options[:default]
        type = options[:type] || "text"

        # .input-wrapper classes
        input_wrapper_classes = ["input-wrapper"]
        input_wrapper_classes << "input-wrapper-#{options[:size]}" if options[:size].present?
        input_wrapper_classes << "focused" if value.present?
        input_wrapper_class = input_wrapper_classes.join(" ")

        # .input-wrapper data attribute
        data_attribute = {
          label: form_builder.object.class.human_attribute_name(name),
          controller: "input"
        }

        # Checkout field wrapped in .input-wrapper div
        content_tag(:div, class: input_wrapper_class, data: data_attribute) do
          targets = ["input.field"]
          targets << "validate.required" if options[:required]
          targets << "date.field" if options[:date]
          targets << options[:target] if options[:target]

          actions = ["keyup->input#placeholder", "change->input#placeholder"]
          actions << "blur->validate#validateField" if options[:required]
          actions << "date#change" if options[:date]
          actions << options[:action] if options[:action]
          
          # Convert to formatted date
          value = I18n.l(value) if options[:date] && value.present?

          form_builder.text_field(name, 
            type: type, 
            value: value,
            disabled: options[:disabled],
            data: {
              target: targets.join(" "),
              action: actions.join(" "),
              validate: options[:required]
            }
          )
        end
      end
      
      private
      
        def get_first_product_image(orderable)
          image = orderable.product_images.first
          if image.nil? && orderable.is_a?(Spina::Shop::Product)
            image = orderable.children.joins(:product_images).first&.product_images&.first || orderable.root.product_images.first
          end
          image
        end

    end
  end
end
