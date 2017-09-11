require 'rails_helper'

RSpec.describe User, type: :model do
  # Describe - describing unit test
  # Context - as a user, as an admin, as a viewer, with a single user, or with multiple users
  context 'with multiple users' do
    describe '.by_last_name' do

      before(:each) do
        User.create(first_name: "Test", last_name: "Testerson", email: "t@t.com", password: '111111')
        User.create(first_name: "Test", last_name: "Sesterson", email: "s@t.com", password: '111111')
        User.create(first_name: "Test", last_name: "Desterson", email: "d@t.com", password: '111111')
      end

      it 'returns all users by last name ASC' do
        users = User.all.by_last_name
        expect(users.first.last_name).to eq('Desterson')
        expect(users[1].last_name).to eq('Sesterson')
        expect(users.last.last_name).to eq('Testerson')
      end

      it 'returns all users by last name DESC' do
        users = User.all.by_last_name(false)
        expect(users.first.last_name).to eq('Testerson')
        expect(users[1].last_name).to eq('Sesterson')
        expect(users.last.last_name).to eq('Desterson')
      end

    end
  end

  context 'with a single user' do
    before(:each) do
      @user = User.create(email: 'test@test.com', password: '111111', first_name: 'Testy',
                  last_name: 'Testerson')
    end

    describe 'validations' do
      it { should validate_presence_of(:first_name) }
      it { should validate_presence_of(:last_name) }
    end

    describe 'associations' do
      it { should have_many(:posts) }
    end

    describe '#info' do
      it 'returns email with sign in count' do
        expect(@user.info).to eq("#{@user.email} has signed in: #{@user.sign_in_count} times.")
      end
    end

    describe '#full_name' do
      it 'returns the users name like last name, first name' do
            expect(@user.full_name).to eq("#{@user.last_name}, #{@user.first_name}")
      end
    end

    describe '#display_name' do
      it 'returns the users name like <first name> <last name>' do
        expect(@user.display_name).to eq("#{@user.first_name} #{@user.last_name}")
      end
    end

    describe '#has_signed_in' do

      it "returns true if the sign_in_count > 0" do
        @user.update(sign_in_count: 1)
        expect(@user.has_signed_in?).to eq(true)
      end

      it "returns false if the sign_in_count == 0" do
        expect(@user.has_signed_in?).to eq(false)
      end
    end
  end
end
