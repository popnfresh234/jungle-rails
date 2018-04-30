class User < ActiveRecord::Base
    has_many :orders
    has_secure_password

    validates :password, presence: true
    validates :password_confirmation, presence: true
    validate :password_equal_to_password_confirmation
    validates :email, presence: true
    validates_uniqueness_of :email
    validates :name, presence: true
    validate :password_must_be_at_least_three_chars

    def password_equal_to_password_confirmation
        if password != password_confirmation
            errors.add(:password, "must match")
        end
    end

    def password_must_be_at_least_three_chars
        unless password != nil && password.length >= 3
            errors.add(:password, "must be at least three chars long")
        end
    end
    def self.authenticate_with_credentials(email, password)
        email = email.gsub(" ", "").downcase
        user = User.find_by_email(email)
        if(user && user.authenticate(password))
            return user
        else 
            return nil
        end
    end

end