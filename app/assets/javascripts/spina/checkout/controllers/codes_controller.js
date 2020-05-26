(() => {
  const application = Stimulus.Application.start()

  application.register("codes", class extends Stimulus.Controller {
    static get targets() {
      return ["input"]
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
      }).then(function() {
        this.sidebar.fetchSummary()
      }.bind(this))
    }

    pressEnter(e) {      
      if (e.keyCode == 13) {
        e.preventDefault()  
        this.addCode()
      }
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }

    get sidebar() {
      return document.querySelector('.sidebar-summary').controller
    }

  })

})()