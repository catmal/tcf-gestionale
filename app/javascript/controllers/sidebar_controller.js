// app/javascript/controllers/tabs_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tabs"
//
export default class extends Controller {
  static targets = ["sidebarContainer", "icon", "link", "sidebarUserMenu"]



  toggle () {
    if (this.sidebarContainerTarget.dataset.expanded === "1") {
      this.collapse()
    } else {
      this.expand()
    }
  }

  connect () {
    this.sidebarUserMenuTarget.hidden = true
    this.sidebarUserMenuTarget.dataset.expanded = "0"
  }

  toggleUserMenu () {
    if (this.sidebarUserMenuTarget.dataset.expanded === "1") {
      this.collapseUserMenu()
    } else {
      this.expandUserMenu()
    }
  }

  collapseUserMenu () {
    this.sidebarUserMenuTarget.hidden = true
    this.sidebarUserMenuTarget.dataset.expanded = "0"

  }

  expandUserMenu () {
    this.sidebarUserMenuTarget.hidden = false
    this.sidebarUserMenuTarget.dataset.expanded = "1"

  }

  collapse () {
    this.sidebarContainerTarget.classList.remove("md:w-1/5")
    this.sidebarContainerTarget.classList.add("sm:w-14")

    this.sidebarContainerTarget.dataset.expanded = "0"

    this.linkTargets.forEach(link => {
      link.classList.add("sr-only")
    })
  }

  expand () {
    this.sidebarContainerTarget.classList.remove("sm:w-14")
    this.sidebarContainerTarget.classList.add("md:w-1/5")
    this.sidebarContainerTarget.dataset.expanded = "1"

    this.linkTargets.forEach(link => {
      link.classList.remove("sr-only")
    })
  }


}

