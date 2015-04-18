require 'spec_helper'

describe ArticlesController do

    describe 'GET #index' do
    end
    
    describe 'GET #show' do

        user = User.create(
          username: "hiroki",
          email: "hiroki@mail.com",
          password: "passpass")

      it "hello" do
        article = create(:article)
        p article

        get :show, id: article
        p assigns(:article)
        p 'hello'
        expect(assigns(:article)).to eq article
      end
    end
    
    describe 'GET #new' do
    end
  end