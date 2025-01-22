import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "output"]

  submit() {
    const formData = new FormData(this.formTarget)
    fetch(this.formTarget.action, {
      method: "POST",
      body: formData
    })
    .then(response => response.json())
    .then(data => {
      this.outputTarget.innerHTML = data
    })
  }
}
