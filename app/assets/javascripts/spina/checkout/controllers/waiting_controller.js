(() => {
  const application = Stimulus.Application.start()

  application.register("codes", class extends Stimulus.Controller {

    connect() {
      setTimeout(function() {
        location.reload()
      }, 3000)
    }

  })
})()
