
const channel = {

    options: {

        channel: 'KudosChannel',
        room: 'kudos'
    },

    actions: {

        received: ({ sent_by, body }) => {

            app.actions.receiveKudo(body);
        }
    }
};

App.cable.subscriptions.create(channel.options, channel.actions);