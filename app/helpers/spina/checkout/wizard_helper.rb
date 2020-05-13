module Spina
  module Checkout
    module WizardHelper

      def loading_gif
        image_tag("spina/checkout/loading.gif", width: 24)
      end

      def checkout_field(form_builder, name, options = {})
        value = options[:value] || form_builder.object.send(name)
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

    end
  end
end
