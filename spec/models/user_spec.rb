describe User do

    #before(:each) {@user = User.new(email: 'user@example.com')}

    #subject {@user}

    #it {should respond_to(:email)}

    it 'check email consistency' do
        user = User.new(email: 'user@example.com')
        expect(user.email).to match 'user@example.com'
    end

    it 'check name consistency' do
        user = User.new(name: 'MyName')
        expect(user.name).to match 'MyName'
    end

end
