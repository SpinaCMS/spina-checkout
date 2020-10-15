(() => {
  const application = Stimulus.Application.start()

  application.register("address-book", class extends Stimulus.Controller {
    static get targets() {
      return []
    }

    chooseAddress(event) {
      let select = event.currentTarget
      let option = select.options[select.selectedIndex]
      this.company.value = option.dataset.company
      this.first_name.value = option.dataset.firstName
      this.last_name.value = option.dataset.lastName
      this.street.value = option.dataset.street
      this.house_number.value = option.dataset.houseNumber
      this.house_number_addition.value = option.dataset.houseNumberAddition
      this.postal_code.value = option.dataset.postalCode
      this.city.value = option.dataset.city

      let array = [this.company, this.first_name, this.last_name, this.street, this.house_number, this.house_number_addition, this.postal_code, this.city]
      array.forEach(function(target) {
        target.dispatchEvent(new Event('change'))
      })
    }

    get first_name() {
      return this.element.querySelector(`input[name="order[delivery_first_name]"]`)
    }

    get last_name() {
      return this.element.querySelector(`input[name="order[delivery_last_name]"]`)
    }

    get company() {
      return this.element.querySelector(`input[name="order[delivery_company]"]`)
    }

    get street() {
      return this.element.querySelector(`input[name="order[delivery_street1]"]`)
    }

    get house_number() {
      return this.element.querySelector(`input[name="order[delivery_house_number]"]`)
    }

    get house_number_addition() {
      return this.element.querySelector(`input[name="order[delivery_house_number_addition]"]`)
    }

    get postal_code() {
      return this.element.querySelector(`input[name="order[delivery_postal_code]"]`)
    }

    get city() {
      return this.element.querySelector(`input[name="order[delivery_city]"]`)
    }

  })

})()