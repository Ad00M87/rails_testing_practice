require 'rails_helper'

RSpec.describe User, type: :model do
  # Describe - describing unit test
  # Context - as a user, as an admin, or as a viewer
  before(:each) do
    @user = User.create(email: 'test@test.com', password: '111111', first_name: 'Testy',
                last_name: 'Testerson')
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
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
