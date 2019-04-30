{ Component, h, render } = window.preact;

SendIcon = (item) ->

    iconProps =
        class: 'fas fa-arrow-right'

    buttonProps =
        class: 'button sm success column w-25'
        onclick: () ->
            props = window.app
            props.to_id = item.id
            render h(window.NewKudo, props), document.body

    h('span', buttonProps, h('i', iconProps, null))

UserItem = (item) ->

    [
        h('span', { class: 'username column w-75' }, item.username),
        SendIcon(item)
    ]

UsersList = (props) ->

    props.users.map (item) ->

        itemProps =
            id: 'user-' + item.id
            class: 'user grid'

        h('div', itemProps, UserItem(item))

class Users extends Component

    constructor: (props) ->

        super(props)
        props.states.map((state) =>

            @setState state
        )

    componentDidMount: () =>

        if !isAuthenticated()
            return

        @props.actions.getUsers()

    render: () =>

        divProps =
            id: 'user-list'
            class: 'p-sm'

        h('div', divProps, UsersList(@state))


Object.assign window, { Users }