(() => {
  const application = Stimulus.Application.start()

  application.register("sidebar-products", class extends Stimulus.Controller {

    connect() {
      this.element["controller"] = this
    }

    fetchProductList() {
      fetch(this.element.dataset.orderItemsUrl)
        .then(response => response.text())
        .then(function(html) {
          this.element.innerHTML = html
        }.bind(this))
    }

  })
})()