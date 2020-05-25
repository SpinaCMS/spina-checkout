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
      })
    }

    get token() {
      return document.querySelector('meta[name="csrf-token"]').content
    }


  })

})()