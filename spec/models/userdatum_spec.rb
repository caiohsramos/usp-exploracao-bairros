require 'rails_helper'

RSpec.describe Userdatum, type: :model do
    # pending "add some examples to (or delete) #{__FILE__}"
    it 'check name consistency' do
        new_data = Userdatum.new(name: 'name')
        expect(new_data.name).to match 'name'
    end

    it 'check comment consistency' do
        new_data = Userdatum.new(comment: 'comment')
        expect(new_data.comment).to match 'comment'
    end

    it 'check user_id consistency' do
        new_data = Userdatum.new(user_id: 5)
        expect(new_data.user_id).to eq 5
    end

    it 'check place_id consistency' do
        new_data = Userdatum.new(place_id: '10')
        expect(new_data.place_id).to match '10'
    end
end
