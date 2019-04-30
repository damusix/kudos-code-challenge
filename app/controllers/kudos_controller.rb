class KudosController < ApplicationController

    after_action :notify_channel, only: [:create]

    def create

        @kudo = Kudo.create create_params
        render json: @kudo
    end

    def sent
        render json: current_user.kudos_sent.order(created_at: :desc)
    end

    def received
        render json: current_user.kudos_received.order(created_at: :desc)
    end

    def total
        render json: current_user.kudos_totals
    end

private

    def create_params

        params.permit(:to_id, :from_id, :amount, :comment)
    end

    def notify_channel
        user = User.find @kudo.to_id
        ActionCable.server.broadcast("chat_kudos", sent_by: user.username, body: @kudo)
    end
end
