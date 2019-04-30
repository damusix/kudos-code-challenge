window.getUserID = () ->
    cookies = document.cookie.split(';');
    user = cookies.filter (c) -> /user\=/.test(c)
    if user[0]
        id = user[0].split('=')[1]

        if id == 'nil'
            null
        else
            id
    else
        null

window.isAuthenticated = () ->
    window.getUserID() != null