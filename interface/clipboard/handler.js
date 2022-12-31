const copy = (text) => {
    const element = document.createElement('textarea')
    element.value = text
    document.body.appendChild(element)
    element.select()
    document.execCommand('copy')
    document.body.removeChild(element)
}

onMessage.push(async (item) => {
    if (item.type == 'clipboard') copy(item.data)
});