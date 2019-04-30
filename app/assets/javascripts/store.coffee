getKudos = (type) ->

    callback = (rs, rj) ->
        Rails.ajax
            url: '/me/kudos/' + type
            type: 'get',
            success: rs,
            error: rj

    new Promise(callback)

initialPayload = ->
    from_id: window.getUserID()
    amount: 0
    comment: ""

app =
    initialState:
        users: []
        usernames: {}
        received: []
        sent: []
        total_received: 0
        total_sent: 0
        payload: initialPayload()

    actions: (update) =>
        receivedKudos: () =>
            getKudos('received').then((res) =>

                update (state) =>
                    state.received = res
                    state
            )

        sentKudos: () =>
            getKudos('sent').then((res) =>

                update (state) =>
                    state.sent = res
                    state
            )
        receiveKudo: (data) =>
            current_user = window.getUserID() * 1

            if (data.to_id == current_user)

                update (state) =>
                    state.received.unshift data
                    state.total_received += data.amount
                    state

        sendKudo: (data) =>

            ajax = fetch '/kudos',
                method: 'post'
                body: JSON.stringify(data)
                headers:
                    'Content-Type': 'application/json'
                    'X-CSRF-Token': Rails.csrfToken()
                credentials: 'same-origin'

            getJson = (res) => res.json()
            setState = (res) =>
                update((state) =>
                    state.sent.unshift res
                    state.total_sent += (res.amount * 1)
                    state
                )

            ajax.then(getJson).then(setState)

        resetPayload: () =>
            update((state) =>
                state.payload = initialPayload()
                state
            )

        getTotals: () =>

            Rails.ajax
                url: '/me/kudos/total'
                type: 'get'
                success: (res) =>
                    update((state) =>

                        state.total_received = res.received
                        state.total_sent = res.sent

                        state
                    )
                error: console.error
        getUsers: () =>

            Rails.ajax
                url: '/users'
                type: 'get'
                success: (res) =>
                    update((state) =>
                        state.users = res

                        for user in res
                            state.usernames[user.id] = user.username

                        state
                    )
                error: console.error


update = flyd.stream()

scanFn = (state, patch) => patch(state)

states = flyd.scan(scanFn, app.initialState, update)
actions = app.actions(update)

window.app = { states, actions }
