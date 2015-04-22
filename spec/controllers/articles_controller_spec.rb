require 'spec_helper'
describe ArticlesController do
 before {request.env["HTTP_REFERER"] = "redirect to back"}
 let(:article) {create(:article)}
 login_user

describe 'GET#show' do
  before {get :show, id: article}
  it {expect(assigns(:article)).to eq article}
  it {expect(response).to render_template :show}
end

describe 'GET #new' do
  before {get :new}
  it {expect(assigns(:article)).to be_a_new(Article)}
  it {expect(response).to render_template :new}
end

describe 'POST #create' do
  context 'valid' do
    it '@article.save' do 
      expect{
        post :create, article: attributes_for(:params_article)
        }.to change(Article, :count).by(1)
      end

      it 'redirects index' do
        post :create, article: attributes_for(:params_article)
        expect(response).to redirect_to users_path
      end
    end
  end

  describe 'DELETE #destroy'  do
    it '@article.destroy' do 
     expect{
      delete :destroy, id: article
      }.to change(Article,:count).by(-1)
    end

    it 'redirects to back' do
      delete :destroy, id: article
      expect(response).to redirect_to "redirect to back"
    end
  end
end


