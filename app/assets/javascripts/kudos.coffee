{ Component, h, render } = window.preact;

class NewKudo extends Component

    constructor: (props) ->

        super props
        props.states.map((state) =>

            state.payload.to_id = props.to_id
            @setState(Object.assign @state, state)
        )

    onSubmit: (e) =>
        e.preventDefault()
        @props.actions.sendKudo @state.payload
        @onDone()

    onChange: (e) =>
        state = @state
        state.payload[e.target.name] = e.target.value

        @setState(state)

    onDone: (e) =>
        e && e.preventDefault()

        @props.actions.resetPayload()
        Rails.$('.overlay')[0].classList.add 'closed'
        @base.reset()
        render null, document.body, @base

    render: () =>

        Rails.$('.overlay')[0].classList.remove 'closed'
        formProps =
            id: 'send-kudos'
            class: 'modal p-sm'
            onSubmit: @onSubmit

        amountProps =
            id: 'kudos-amount'
            onChange: @onChange
            validate: true
            required: true
            type: 'number'
            name: 'amount'
            placeholder: 'Amount'

        messageProps =
            id: 'kudos-comment'
            onChange: @onChange
            validate: true
            required: true
            type: 'text'
            name: 'comment'
            placeholder: 'Message'

        buttonProps =
            type: 'submit'
            class: 'green'
            value: 'Send!'

        cancelProps =
            type: 'button'
            class: 'red'
            value: 'Cancel'
            onClick: @onDone

        sending_to = @state.usernames[@state.payload.to_id]

        title = 'Send Kudos to ' + sending_to + '!'

        h('form', formProps, [

            h('h1', { class: 'text-center' }, title)

            h('div', { class: 'field' }, [
                h('label', { for: 'kudos-amount'}, 'Amount:'),
                h('input', amountProps, null)
            ]),

            h('div', { class: 'field' }, [
                h('label', { for: 'kudos-comment'}, 'Message:'),
                h('input', messageProps, null)
            ]),

            h('div', { class: 'actions' }, [
                h('input', cancelProps, null),
                h('input', buttonProps, null),
            ]),
        ])

KudoItem = (which, state, item) ->

    username = if which == 'sent' then state.usernames[item.to_id] else state.usernames[item.from_id]
    term = if which == 'sent' then 'to' else 'from'
    date = dayjs(item.created_at).format("MM/DD/YY [at] hh:mm a")
    message = "#{which} #{item.amount} kudos #{term} #{username}"

    [
        h('i', { class: 'date' }, "#{date} - "),
        h('span', { class: 'message' }, message),
        h('div', { class: 'comment' }, h('b', null, item.comment)),
    ]

KudosList = (which, state) ->
    state[which].map (item) ->
        itemProps =
            id: 'kudo-' + item.id
            class: 'kudos'
        h 'div', itemProps, KudoItem(which, state, item)

class Kudos extends Component

    constructor: (props) ->

        super props
        props.states.map((state) =>

            @setState state
        )


    componentDidMount: () =>

        if (!isAuthenticated())
            return

        @props.actions.sentKudos()
        @props.actions.receivedKudos()
        @props.actions.getTotals()

    render: () =>

        receiveList = h('div', { id: 'received' }, [

            h('h3', null, 'Received (' + @state.total_received + ')'),
            KudosList('received', @state)
        ])

        sentList = h('div', { id: 'sent' }, [

            h('h3', null, 'Sent (' + @state.total_sent + ')'),
            KudosList('sent', @state)
        ])

        h('section', { id: 'kudos' }, [
            receiveList,
            sentList
        ])


Object.assign window, { NewKudo, Kudos }