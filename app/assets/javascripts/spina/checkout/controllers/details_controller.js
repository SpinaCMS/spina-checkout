(() => {
  const application = Stimulus.Application.start()

  application.register("details", class extends Stimulus.Controller {
    static get targets() {
      return ["email", "separateDeliveryAddress", "deliveryAddress", "loginLink", "loginNotification"]
    }

    connect() {
      this.toggleSeparateDeliveryAddress()
      if(this.loginPopup) this.showLoginModal()
    }

    showLoginModal() {
      if (!this.loggedIn && !this.element.hasAttribute("data-errors") && this.emailTarget.value.length == 0) {
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

    checkExistingCustomerAccount() {
      if (!this.loggedIn) {
        let url = this.loginNotificationTarget.dataset.existingCustomerAccountPath
        fetch(url, {
          method: "POST",
          headers: {
            'X-CSRF-Token': this.token,
            'Content-Type': 'application/json'
          },
          credentials: "same-origin",
          body: JSON.stringify({
            email: this.emailTarget.value
          })
        }).then(function(response) {
          if (response.status == 200) {
            return response.text()
          }
        }).then(function(html) {
          if (html) {
            this.loginNotificationTarget.innerHTML = html
          } else {
            this.loginNotificationTarget.innerHTML = ""
          }
        }.bind(this))
      } 
    }
    
    get separateDelivery() {
      return this.separateDeliveryAddressTarget.checked
    }

    get loggedIn() {
      return document.body.hasAttribute("data-logged-in")
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }

    get loginPopup() {
      return this.element.hasAttribute('data-login-popup')
    }

  })

})()