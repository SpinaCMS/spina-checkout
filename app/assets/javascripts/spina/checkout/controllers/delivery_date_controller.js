(() => {
  const application = Stimulus.Application.start()

  application.register("delivery-date", class extends Stimulus.Controller {
    static get targets() {
      return ["date"]
    }

    connect() {
      fetch(this.element.dataset.deliveryDateUrl, {credentials: "same-origin"})
        .then((response) => response.json())
        .then(function(response) {
          this.dateTarget.innerText = response.date
        }.bind(this))
    }

  })

})()