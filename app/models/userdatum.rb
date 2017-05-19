class Userdatum < ApplicationRecord
    validates_presence_of :name, message: 'não pode estar em branco'
    belongs_to :user
    
    include Obfuscate

    def to_param
        encrypt id
    end
end
