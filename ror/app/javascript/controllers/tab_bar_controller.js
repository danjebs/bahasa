import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['tabs', 'sections']

  connect() {
    const firstTab = this.tabsTargets[0]
    this.showSection(firstTab?.dataset.tabId)
  }

  onClickTab = (e) => {
    const clickedId = e.currentTarget.dataset.tabId
    this.showSection(clickedId)
  }

  showSection(id) {
    this.sectionsTargets.forEach((section) => {
      section.classList.toggle("hidden", section.dataset.sectionId !== id)
    })

    this.tabsTargets.forEach((tab) => {
      tab.classList.toggle("bg-red-100", tab.dataset.tabId === id)
    })
  }
}
