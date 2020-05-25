(() => {
  const application = Stimulus.Application.start()

  application.register("modal", class extends Stimulus.Controller {
    static get targets() {
      return [ "firstInput" ]
    }

    connect() {
      this.element.style.display = 'flex'
      this.closeAllOtherModals()
      if (this.hasFirstInputTarget) {
        this.firstInputTarget.focus()
      }
    }

    close() {
      document.body.removeChild(this.element)
    }

    closeAllOtherModals() {
      document.querySelectorAll('[data-controller="modal"]').forEach(function(modal) {
        // As long as it's not this modal
        if (this.element != modal) document.body.removeChild(modal)
      }.bind(this))
    }

    escClose(event) {
      if (event.keyCode == 27) this.close()
    }

    stopPropagation(event) {
      event.stopPropagation()
    }
  })
})()
