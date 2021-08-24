(() => {
  const application = Stimulus.Application.start()

  application.register("analytics", class extends Stimulus.Controller {
    
    connect() {
      this.element[this.identifier] = this
      this.trackCheckout()
    }
    
    trackCheckout() {
      ga("ec:setAction", "checkout", {
        "step": this.step
      })
    }
    
    get step() {
      return parseInt(this.element.dataset.checkoutStep)
    }
    
  })
})()