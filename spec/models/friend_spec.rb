require 'rails_helper'

RSpec.describe Friend, type: :model do
    # pending "add some examples to (or delete) #{__FILE__}"

    it 'check user_id consistency' do
        friend = Friend.new(user_id: 7)
        expect(friend.user_id).to eq 7
    end

    it 'check friend_id consistency' do
        friend = Friend.new(friend_id: 9)
        expect(friend.friend_id).to eq 9
    end

    it 'check status consistency' do
        friend = Friend.new(status: 1)
        expect(friend.status).to eq 1
    end

end
