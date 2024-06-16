import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'
import dayjs from 'dayjs'

export default class extends Controller {
  static targets = ['card', 'front', 'back']

  connect() {
    this.timerStarted = dayjs()
  }

  turnCard() {
    this.frontTarget.classList.toggle('hidden')
    this.backTarget.classList.toggle('hidden')

    const { id } = this.cardTarget.dataset
    this.updateDeckCard({
      id,
      status: 'completed',
      outcome: 'peek',
      timeTaken: dayjs().diff(this.timerStarted, 'seconds')
    })
  }

  async flashCard() {
    const { id } = this.cardTarget.dataset
    const response = await this.updateDeckCard({
      id,
      status: 'completed',
      outcome: 'flash',
      timeTaken: dayjs().diff(this.timerStarted, 'seconds')
    })

    if (response.ok) {
      this.nextCard()
    }
  }

  nextCard() {
    Turbo.visit(window.location.pathname)
  }

  async updateDeckCard({ id, status, outcome, timeTaken }) {
    const url = `/deck_cards/${id}`

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
