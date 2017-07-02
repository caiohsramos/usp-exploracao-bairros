module GravatarApi

    def self.small_photo(email)
        "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=50"
    end

    def self.mid_photo(email)
        "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=100"
    end

    def self.big_photo(email)
        "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=150"
    end
end