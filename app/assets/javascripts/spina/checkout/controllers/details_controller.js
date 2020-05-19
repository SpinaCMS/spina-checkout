(() => {
  const application = Stimulus.Application.start()

  application.register("details", class extends Stimulus.Controller {
    static get targets() {
      return ["email", "separateDeliveryAddress", "deliveryAddress"]
    }

    connect() {
      this.toggleSeparateDeliveryAddress()
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