(() => {
  const application = Stimulus.Application.start()

  application.register("shopping-cart", class extends Stimulus.Controller {
    static get targets() {
      return []
    }

    setQuantity(order_item_url, quantity) {
      fetch(order_item_url, {
        method: 'PUT',
        headers: {
          'X-CSRF-Token': Rails.csrfToken(),
          'Content-Type': 'application/json'
        },
        credentials: 'same-origin',
        body: JSON.stringify({
          quantity: quantity
        })
      }).then(function(response) {
          if (response.status == 200) this.sidebar.fetchSummary()
        }.bind(this))
    }

    add(event) {
      let field = event.currentTarget.parentElement.querySelector("input")
      let quantity = parseInt(field.value)
      field.value = Math.min(quantity + 1, this.max(field))
      field.dispatchEvent(new Event('change'))
    }

    subtract(event) {
      let field = event.currentTarget.parentElement.querySelector('input')
      let quantity = parseInt(field.value)
      field.value = Math.max(quantity - 1, 1)
      field.dispatchEvent(new Event('change'))
    }

    addToCart(event) {
      let field = event.currentTarget
      field.value = Math.min(field.value, this.max(field))
      field.value = Math.max(field.value, 1)
      this.setQuantity(field.dataset.orderItemUrl, field.value)
    }

    max(field) {
      return parseInt(field.dataset.maximum || 9999)
    }

    get sidebar() {
      return document.querySelector('.sidebar-summary').controller
    }

  })
})()