class User < ApplicationRecord
    has_secure_password
    validates :password, length: { in: 6..20 }
    validates :login, uniqueness: true, presence: true
end
