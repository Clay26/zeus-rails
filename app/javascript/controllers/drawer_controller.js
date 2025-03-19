import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["drawer", "backdrop"]

open() {
  this.backdropTarget.classList.remove("hidden");

  requestAnimationFrame(() => {
    this.backdropTarget.classList.remove("opacity-0");
  });

  this.drawerTarget.classList.remove("hidden");
 
  requestAnimationFrame(() => {
    this.drawerTarget.classList.remove("translate-x-full");
    this.drawerTarget.classList.add("translate-x-0");
  });
}

close() {
  this.drawerTarget.classList.remove("translate-x-0");
  this.drawerTarget.classList.add("translate-x-full");

  this.backdropTarget.classList.add("opacity-0");

  this.drawerTarget.addEventListener("transitionend", () => {
    this.drawerTarget.classList.add("hidden");
    this.backdropTarget.classList.add("hidden");
  }, { once: true });
}
}
