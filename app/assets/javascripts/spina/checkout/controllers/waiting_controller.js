(() => {
  const application = Stimulus.Application.start()

  application.register("waiting", class extends Stimulus.Controller {

    connect() {
      setTimeout(function() {
        location.reload()
      }, 3000)
    }

  })
})()
