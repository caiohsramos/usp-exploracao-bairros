require 'rails_helper'

RSpec.describe Review, type: :model do

    it 'check user_id consistency' do
        review = Review.new(user_id: 10)
        expect(review.user_id).to eq 10
    end

    it 'check place_id consistency' do
        review = Review.new(place_id: '15')
        expect(review.place_id).to match '15'
    end

    it 'check comment consistency' do
        review = Review.new(comment: 'Comment')
        expect(review.comment).to match 'Comment'
    end

    it 'check rate consistency' do
        review = Review.new(rate: 3)
        expect(review.rate).to eq 3
    end
end
