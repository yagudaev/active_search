import { Controller } from "stimulus"
import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ['input']

  submit() {
    const urlParams = Rails.serializeElement(this.element)
    const query = this.inputTarget.value

    history.pushState({}, `Search for ${query}`, `?${urlParams}`)
    Rails.fire(this.element, 'submit')
  }
}
