import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['button', 'content']

  toggleOpen = () => {
    const { contentTarget, buttonTarget } = this

    contentTarget.classList.toggle('hidden')
    buttonTarget.classList.toggle('rotate-180')
  }
}