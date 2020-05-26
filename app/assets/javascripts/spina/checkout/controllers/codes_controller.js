(() => {
  const application = Stimulus.Application.start()

  application.register("codes", class extends Stimulus.Controller {
    static get targets() {
      return ["input", "form"]
    }

    connect() {
      this.formTarget.style.display = "none"
    }

    addCode() {
      fetch(this.element.dataset.url, {
        method: "POST",
        headers: {
          'X-CSRF-Token': this.token,
          'Content-Type': 'application/json'
        },
        credentials: "same-origin",
        body: JSON.stringify({
          code: this.inputTarget.value
        })
      }).then(function(response) {
        if (response.status == 200) {
          this.sidebar.fetchSummary()
        } else {
          alert("Code ongeldig")
        }
      }.bind(this))
    }

    pressEnter(e) {      
      if (e.keyCode == 13) {
        e.preventDefault()  
        this.addCode()
      }
    }

    showForm(e) {
      let button = e.currentTarget
      button.parentElement.removeChild(button)
      this.formTarget.style.display = "flex"
      this.inputTarget.focus()
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }

    get sidebar() {
      return document.querySelector('.sidebar-summary').controller
    }

  })

})()