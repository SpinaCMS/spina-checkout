(() => {
  const application = Stimulus.Application.start()

  application.register("sidebar-summary", class extends Stimulus.Controller {

    connect() {
      this.fetchSummary()
    }

    fetchSummary() {
      fetch(this.element.dataset.summaryUrl)
        .then(response => response.text())
        .then(function(html) {
          this.element.innerHTML = html
        }.bind(this))
    }

    fetchSummaryDelayed() {
      setTimeout(function() {
        this.fetchSummary()
      }.bind(this), 100)
    }

  })
})()