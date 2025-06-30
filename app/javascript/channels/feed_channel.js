import consumer from "channels/consumer"

consumer.subscriptions.create("FeedChannel", {
  connected() {
    console.log("Connected to feed channel")
  },

  disconnected() {
    console.log("Disconnected from feed channel")
  },

  received(data) {
    const messages = document.getElementById("messages")
    messages.insertAdjacentHTML("beforeend", data.message)
    messages.scrollTop = messages.scrollHeight
  }
})
