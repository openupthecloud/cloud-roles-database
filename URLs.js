var temp = [...document.querySelectorAll('.jcs-JobTitle')]
    .map(elem => `${window.location.origin}${elem.getAttribute('href')}`)

window.localStorage.setItem(
    'url',
    temp.join('\r').concat(window.localStorage.getItem('url') || [])
)

setTimeout(function () {
    document.querySelector('.pagination-list').lastChild.firstChild.click()
}, 2000);