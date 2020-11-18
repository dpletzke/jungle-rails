# frozen_string_literal: true

require 'rails_helper'
require 'pp'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }

    it { should validate_presence_of(:password_confirmation) }

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

    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password }
  end
end
