import { Controller } from '@hotwired/stimulus'

const ACTIVE_CLASSES = 'bg-gradient-to-r from-primary-500 to-primary-600 hover:to-primary-500 text-white dark:from-primary-700 dark:to-primary-600 dark:hover:to-primary-700 dark:text-primary-100'.split(' ')
const INACTIVE_CLASSES = 'text-gray-500 dark:text-gray-300'.split(' ')

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
      if (tab.dataset.tabId === id) {
        tab.classList.add(...ACTIVE_CLASSES)
        tab.classList.remove(...INACTIVE_CLASSES)
      } else {
        tab.classList.remove(...ACTIVE_CLASSES)
        tab.classList.add(...INACTIVE_CLASSES)
      }
    })
  }
}
