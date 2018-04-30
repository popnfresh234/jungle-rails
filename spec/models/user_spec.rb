require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'must have a password' do
      user = User.new({email: "bob@bob.bob", name: 'Bob', password: nil, password_confirmation: 'test'})
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")      
    end

    it 'must have a password confirmation' do
      user = User.new({email: "bob@bob.bob", name: 'Bob', password: "test", password_confirmation: nil})
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'must have the same value for password and password confirmation' do
      user = User.new({password: "test", password_confirmation: "oops"})
      user.valid?
      expect(user.errors.full_messages).to include("Password must match")
    end

    it 'must have a unique email' do
      User.create!({email: "bob@bob.bob", name: 'Bob', password: "test", password_confirmation: 'test'})
      user = User.new({email: "bob@bob.bob", name: 'Bob', password: "test", password_confirmation: 'test'})
      user.valid?
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'must contain email' do 
      user = User.new({email: nil, name: 'Bob', password: "test", password_confirmation: 'test'})
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'must contain name' do 
      user = User.new({email: 'bob@bob.bob', name: nil, password: "test", password_confirmation: 'test'})
      user.valid?
      expect(user.errors.full_messages).to include("Name can't be blank")
    end

    it 'must have a password length of at least 3 chars' do
      user = User.new({email: 'bob@bob.bob', name: 'Bob', password: "ab", password_confirmation: 'a'})
      user.valid?
      expect(user.errors.full_messages).to include("Password must be at least three chars long")
    end


  end

  describe '.authenticate_with_credentials' do
    it 'should return nil if user not found' do 
      User.create!({email: "bob@bob.bob", name: 'Bob', password: "test", password_confirmation: 'test'})
      user = User.authenticate_with_credentials("boB@bob .bob", "test")
      puts user
      expect(user).to_not be nil
    end
  end
end
