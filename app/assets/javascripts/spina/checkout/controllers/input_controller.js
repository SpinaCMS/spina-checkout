(() => {
  const application = Stimulus.Application.start()

  application.register("input", class extends Stimulus.Controller {
    static get targets() {
      return ["field"]
    }

    placeholder() {
      this.element.classList.toggle("focused", this.fieldTarget.value.length > 0)
      this.removeErrorStyling()
    }

    removeErrorStyling() {
      this.fieldTarget.parentElement.classList.remove('field_with_errors')
    }

  })

})()