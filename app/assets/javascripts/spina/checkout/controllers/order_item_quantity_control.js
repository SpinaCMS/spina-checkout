(() => {
  const application = Stimulus.Application.start()

  application.register("order-item-quantity-control", class extends Stimulus.Controller {
    static get targets() {
      return ["quantityField", "number"]
    }

    subtract(event) {
      event.preventDefault()
      if(this.number > 1) {
        this.numberTarget.textContent = this.number - 1
      }
      this.changeQuantity()
    }

    add(event) {
      event.preventDefault()
      this.numberTarget.textContent = this.number + 1
      this.changeQuantity()
    }

    changeQuantity() {
      this.quantityFieldTarget.value = this.number
    }

    get number() {
      return parseInt(this.numberTarget.textContent)
    }
    
  })
})()
