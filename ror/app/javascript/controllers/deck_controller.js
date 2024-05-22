import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'
import dayjs from 'dayjs'

export default class extends Controller {
  static targets = ['card', 'front', 'back']

  connect() {
    this.index = 0
    this.showCurrentCard()
  }

  turnCard() {
    const cardTarget = this.cardTargets[this.index]
    const frontTarget = this.frontTargets[this.index]
    const backTarget = this.backTargets[this.index]

    frontTarget.classList.toggle('hidden')
    backTarget.classList.toggle('hidden')

    let { id } = cardTarget.dataset
    this.updateDeckCard({
      id,
      status: 'completed',
      outcome: 'hint',
      timeTaken: dayjs().diff(this.timerStarted, 'seconds')
    })
  }

  async flashCard() {
    const cardTarget = this.cardTargets[this.index]

    let { id } = cardTarget.dataset
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
    this.index++
    this.showCurrentCard()
  }


  showCurrentCard() {
    this.cardTargets.forEach((element, index) => {
      element.hidden = index !== this.index
    })

    this.timerStarted = dayjs()
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
