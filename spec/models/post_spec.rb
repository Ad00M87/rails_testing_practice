require 'rails_helper'

RSpec.describe Post, type: :model do

  context 'with multiple posts' do
    describe '.by_title' do

      before(:each) do
          @current_user = User.create(first_name: 'Test', last_name: 'Testy', email: 't@t.com', password: '111111')
          @current_user.posts.create(title: 'Hi I am yellow', body: 'This is amazing, because I am yellow')
          @current_user.posts.create(title: 'Yo I am yellow', body: 'This is amazing, because I am yellow')
          @current_user.posts.create(title: 'Say I am yellow', body: 'This is amazing, because I am yellow')
      end

        it 'returns all posts by title ASC' do
          posts = @current_user.posts.all.by_title
          expect(posts.first.title).to eq('Hi I am yellow')
          expect(posts[1].title).to eq('Say I am yellow')
          expect(posts.last.title).to eq('Yo I am yellow')
        end

    end
  end

  context 'with one post' do
    before(:each) do
      @current_user = User.create(email: 'test@test.com', password: '111111', first_name: 'Testy',
                  last_name: 'Testerson')
      @post = @current_user.posts.create(title: 'Say I am yellow', body: 'This is amazing, because I am yellow')
    end

    describe 'validations' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:body) }
    end

    describe '#info' do
      it 'returns users full name with title of post' do
        expect(@post.info).to eq("#{@current_user.full_name} wrote the post titled: #{@post.title}")
      end
    end

  end

end
