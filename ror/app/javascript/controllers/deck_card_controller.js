import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'
import dayjs from 'dayjs'

export default class extends Controller {
  static targets = ['card', 'front', 'back']

  connect() {
    this.timerStarted = dayjs()
  }

  turnCard() {
    this.timerCompleted = dayjs()

    this.frontTarget.classList.toggle('hidden')
    this.backTarget.classList.toggle('hidden')
  }

  markRight() {
    this.markOutcomeAndShowNextCard('flash')
  }

  markWrong() {
    this.markOutcomeAndShowNextCard('peek')
  }

  async markOutcomeAndShowNextCard(outcome) {
    const { id } = this.cardTarget.dataset

    const response = await this.updateDeckCard({
      outcome,
      id,
      status: 'completed',
      timeTaken: this.timerCompleted.diff(this.timerStarted, 'seconds')
    })

    if (response.ok) {
      Turbo.visit(window.location.pathname)
    } else {
      alert('Something went wrong, card didn\'t update')
    }
  }

  async updateDeckCard({ id, status, outcome, timeTaken }) {
    const url = `/deck-cards/${id}`

    const response = await patch(url, {
      body: JSON.stringify({
        deck_card: {
          status, outcome,
          time_taken: timeTaken
        }
      }),
      responseKind: 'json'
    })

    return response.response
  }
}
