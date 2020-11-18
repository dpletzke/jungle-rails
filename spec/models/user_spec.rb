# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe User, type: :model do
  describe 'form validations of' do
    context 'name' do
      it { should validate_presence_of(:name) }
    end

    context 'email' do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email).case_insensitive }
    end

    context 'password & confirmation' do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }
      it { should validate_presence_of(:password_confirmation) }
      it { should validate_presence_of(:password_digest) }
      it { should have_secure_password }
      it 'should validate password and confirmation equality' do
        user = User.new(
          name: 'Bob',
          email: 'b@p.com',
          password: 'password',
          password_confirmation: 'not_password'
        )

        user.save

        expect(user.errors.full_messages).to include(
          "Password confirmation doesn't match Password"
        )
      end
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(
        name: 'Bob',
        email: 'b@p.com',
        password: 'password',
        password_confirmation: 'password'
      )
      @user.save
    end
    it 'should accept correct credentials' do
      found_user = User.authenticate_with_credentials('b@p.com', 'password')

      expect(found_user.name).to eq 'Bob'
    end

    it 'should reject wrong credentials' do
      found_user = User.authenticate_with_credentials('b@p.com', 'not_password')

      expect(found_user).to be_falsy
    end

    it 'should accept leading and trailing whitespace in email input' do
      found_user = User.authenticate_with_credentials(
        '  b@p.com  ', 'password'
      )

      expect(found_user.name).to eq 'Bob'
    end

    it 'should accept email case-insensitively' do
      found_user = User.authenticate_with_credentials(
        '  b@P.CoM  ', 'password'
      )

      expect(found_user.name).to eq 'Bob'
    end
  end
end
