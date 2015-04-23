require 'spec_helper'
describe ArticlesController do
  let(:article) {create(:article)}
  let(:valid_article) {attributes_for(:params_article)}
  let(:error_article) {attributes_for(:invalid_article)}
  shared_examples("index/show/create/destroy") do
    describe 'GET #index' do
      before do
        get :index
      end

      it 'populates an array of article' do
        a1,a2 = create(:article),create(:article)
        expect(assigns(:articles)).to match_array([a1,a2])
      end
      
      it 'render index' do
        expect(response).to render_template :index
      end
    end
    
    describe 'GET#show ->' do
      before do
        get :show, id: article
      end
      
      it '@article' do
        expect(assigns(:article)).to eq article
      end
      
      it 'redirects show' do 
        expect(response).to render_template :show
      end
    end

    describe 'GET #new ->' do
      before do
        get :new
      end

      it 'new @article' do
        expect(assigns(:article)).to be_a_new(Article)
      end
      
      it 'render new' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create ->' do
      context 'valid ->' do
        it '@article.save' do 
          expect{post :create, article: valid_article}.to change(Article, :count).by(1)
        end

        it 'redirects index' do
          post :create, article: valid_article
          expect(response).to redirect_to users_path
        end
      end

      context 'invalid ->' do
        it 'not @article.save' do
          expect{post :create, article: error_article}.to raise_error
        end
        it 're-render new',focus: true do  
          post :create, article: error_article
          expect(response).to redirect_to new_article_path  
        end
      end
    end

    describe 'DELETE #destroy ->'  do
      before do
        request.env["HTTP_REFERER"] = 'redirect to back'
      end

      it '@article.destroy' do
        article
        expect{delete :destroy, id: article}.to change(Article,:count).by(-1)
      end

      it 'redirects to back' do
        delete :destroy, id: article
        expect(response).to redirect_to 'redirect to back' 
      end
    end
  end

  describe 'user access ->' do
    login_user
    it_behaves_like "index/show/create/destroy"
  end

  describe  'user not access ->' do
    describe 'GET #index' do
      it 'redirect_to sign_in' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end


