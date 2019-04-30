class User < ApplicationRecord

    has_many :kudos_received, class_name: :Kudo, foreign_key: :to_id
    has_many :kudos_sent, class_name: :Kudo, foreign_key: :from_id

    def kudos_totals

        @received = self.kudos_received.inject(0) { |sum, kudo| sum + kudo.amount }
        @sent = self.kudos_sent.inject(0) { |sum, kudo| sum + kudo.amount }

        { :received => @received, :sent => @sent }
    end
end
