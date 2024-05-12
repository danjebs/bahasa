import { Controller } from '@hotwired/stimulus'
import { patch } from '@rails/request.js'
import Sortable from 'sortablejs'

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: '.reorder-handle',
      onStart: this.startDrag.bind(this),
      onEnd: this.endDrag.bind(this)
    })
  }

  // TODO: make theis an arrow function
  startDrag(e) {
    // TODO: add collapsed flag for all sections into state, then collapse all sections
  }

  async endDrag(e) {
    let { id, model } = e.item.dataset
    const url = this.data.get('url').replace(':id', id)

    const response = await patch(url, {
      body: JSON.stringify({
        [model]: {
          position: e.newIndex + 1
        }
      }),
      responseKind: 'json'
    })

    if (response.ok) {
      // TODO: get collapsed flags for all sections from state, set collapsed state back
    } else {
      // TODO: show error, maybe in toast?
    }
  }
}