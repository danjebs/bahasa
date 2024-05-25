import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['modal']

  onOpen() {
    this.modalTarget.showModal()
  }

  close() {
    this.modalTarget.close()
  }
}
