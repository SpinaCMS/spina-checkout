module Spina
  module Checkout
    module WizardHelper

      def loading_gif
        image_tag("spina/checkout/loading.gif", width: 24)
      end

      def checkout_field(form_builder, name, value: nil, size: 'default', target: nil, action: nil, required: false, date: false, disable_autocomplete: false, password: false, disabled: false)
        value = value || form_builder.object.send(name)
        content_tag(:div, class: "input-wrapper input-wrapper-#{size} #{'focused' if value.present?}", data: {label: form_builder.object.class.human_attribute_name(name), controller: "input #{'date' if date}"}) do
          value = l(value, format: '%d/%m/%Y') if date && value.present?
          form_builder.text_field(name, type: password ? "password" : "text", value: value, autocomplete: (disable_autocomplete ? 'off' : nil), disabled: disabled, data: {target: "#{target} #{'validate.required' if required} input.field #{'date.field' if date}", action: "#{action} keyup->input#placeholder change->input#placeholder #{'blur->validate#validateField' if required} #{'date#change' if date}", validate: required})
        end
      end

    end
  end
end
