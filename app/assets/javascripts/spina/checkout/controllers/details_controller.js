(() => {
  const application = Stimulus.Application.start()

  application.register("details", class extends Stimulus.Controller {
    static get targets() {
      return ["email", "separateDeliveryAddress", "deliveryAddress", "loginLink"]
    }

    connect() {
      this.toggleSeparateDeliveryAddress()
      this.showLoginModal()
    }

    showLoginModal() {
      if (!document.body.hasAttribute("data-logged-in") && !this.element.hasAttribute("data-errors") && this.emailTarget.value.length == 0) {
        this.loginLinkTarget.click()
      }
    }
    
    toggleSeparateDeliveryAddress() {
      if (this.separateDelivery) {
        this.deliveryAddressTarget.style.display = 'block'
      } else {
        this.deliveryAddressTarget.style.display = 'none'
      }
    }
    
    get separateDelivery() {
      return this.separateDeliveryAddressTarget.checked
    }

  })

})()