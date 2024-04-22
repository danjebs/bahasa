import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['collapsible']

  toggleOpen() {
    const element = this.collapsibleTarget
    element.hidden = !element.hidden
  }
}