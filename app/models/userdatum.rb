class Userdatum < ApplicationRecord
    validates_presence_of :name, message: 'não pode estar em branco'
    belongs_to :user
end
