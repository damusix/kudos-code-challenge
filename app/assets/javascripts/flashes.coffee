flashes = Rails.$ '#flashes .alert'

for flash in flashes
    close = Rails.$ '.close', flash

    closeFn = (e) ->
        e && e.preventDefault()
        flash.remove()

    close[0].onclick = closeFn

    setTimeout closeFn, 8000