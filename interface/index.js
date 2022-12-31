var onMessage = []
var onReady = []

console.log("HEY")

const callback = async (name, data) => {
    const re = await fetch(`https://${GetParentResourceName()}/${name}`, {method: 'POST',headers: {'Content-Type': 'application/json; charset=UTF-8',},body: JSON.stringify(data)})
    return re.json()
}


$(document).ready(() => onReady.forEach(e => e()))

window.addEventListener('message', (event) => onMessage.forEach(e => e(event.data)))