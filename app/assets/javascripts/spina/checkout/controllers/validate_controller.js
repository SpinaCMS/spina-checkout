(() => {
  const application = Stimulus.Application.start()

  application.register("validate", class extends Stimulus.Controller {
    static get targets() {
      return ["required", "country"]
    }

    connect() {
      this.validateAll()
    }

    validateField(event) {
      let field = event.currentTarget
      this.validate(field)
    }

    validateAll() {
      this.requiredTargets.forEach(function(field) {
        this.validate(field, false)
      }.bind(this))
    }

    validate(field, invalid_labels = true) {
      let wrapper = field.closest('.input-wrapper')
      let valid = false
      let regex = null

      switch(field.dataset.validate) {
        case 'email':
          regex = /\S+@\S+\.\S+/
          valid = regex.test(field.value)
          break
        default:
          valid = field.value.length > 0
      }

      wrapper.classList.toggle('valid', valid)
      if (invalid_labels) {
        wrapper.classList.toggle('invalid', !valid)
      }
    }

  })
})()
