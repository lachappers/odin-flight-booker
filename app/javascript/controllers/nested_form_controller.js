import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  // connect() {
  // }
  static targets = ["target", "template", "pax", "hideable", "passengerCount"]
  // static classes = [ "supported" ]
  static values = {
    number: Number,
    pax: Number
  }
  // { pax: {type: Number }

  initialize(){
    // this.paxTarget.textContent = this.numberValue
    this.index = this.paxValue
    console.log(this.index)
  }

  connect(){
    // this.index = 
    // this.paxTarget.textContent = this.numberValue
    // console.log(this.paxValue)

  }

  add_association(event) {
    event.preventDefault()
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime().toString())
    this.targetTarget.insertAdjacentHTML('beforebegin', content)
    this.index++
    console.log(this.index)
    if (this.index > 1){
      this.showTargets()
    }
  }
  remove_association(event) {
    event.preventDefault()
    let item = event.target.closest(".nested-fields")
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
    this.index--

    if (this.index == 1){
      this.hideTargets()
    }
    console.log(this.index)
    
    // console.log(event.params)
  }

  hideTargets() {
    this.hideableTargets.forEach( el => {
      el.hidden = true
    })
  }

  showTargets() {
    this.hideableTargets.forEach(el => {
      el.hidden = false
    })
  }

  toggleTargets(){
    this.hideableTargets.forEach(el => {
      el.hidden = !el.hidden
    })    
  }

}
