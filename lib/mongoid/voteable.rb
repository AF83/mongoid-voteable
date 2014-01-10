require 'mongoid'

module Mongoid

  module Voteable

    extend ActiveSupport::Concern

    included do
      field :votes_up, :type => Integer, :default => 0
      field :votes_down, :type => Integer, :default => 0
      field :voters, :type => Array, :default => []
    end

    def votes
      votes_up + votes_down
    end

    %w|up down|.each do |direction|
      define_method "vote_#{direction}" do |*args|
        voter = args.pop
        amount = if args.any?
          args.pop
        elsif direction == "up"
          1
        else
          -1
        end

        vote amount, voter, "votes_#{direction}".to_sym
      end
    end

    def vote(amount, voter, counter=nil)
      id = voter_id(voter)
      counter ||= amount > 0 ? :votes_up : :votes_down

      unless voted?(id)
        self.inc counter, amount.to_i
        self.push :voters, id
      end
    end

    def voted?(voter)
      id = voter_id(voter)
      voters.include?(id)
    end

    def vote_count
      voters.count
    end

    private

    def voter_id(voter)
      if voter.respond_to?(:_id)
        voter._id
      else
        voter
      end
    end

  end

end
