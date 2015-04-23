require 'spec_helper'
describe ArticlesController do
  let(:article) {create(:article)}
  let(:valid_article) {attributes_for(:params_article)}
  let(:error_article) {attributes_for(:params_article,title: nil)}
  
  describe 'User access' do
    login_user
    describe 'GET #index' do
      before do
        get :index
      end

      it 'populates an array of articles' do
        a1,a2 = create(:article),create(:article)
        expect(assigns(:articles)).to match_array([a1,a2])
      end
      
      it 'renders the index template' do
        expect(response).to render_template :index
      end
    end
    
    describe 'GET#show' do
      before do
        get :show, id: article
      end
      
      it 'assigns the requested article to @article' do
        expect(assigns(:article)).to eq article
      end
      
      it 'renders the show template' do 
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      before do
        get :new
      end

      it 'assigns a new Article to @article' do
        expect(assigns(:article)).to be_a_new(Article)
      end
      
      it 'renders the new template' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'creates a new article' do 
          expect{post :create, article: valid_article}.to change(Article, :count).by(1)
        end

        it 'redirects to the index' do
          post :create, article: valid_article
          expect(response).to redirect_to users_path
        end
      end

      context 'with invalid attributes'  do
        it 'does not save the new article' do
          expect{post :create, article: error_article }.to change(Article, :count).by(0)
        end
        it 're_redirects to the new' do  
          post :create, article: error_article
          expect(response).to redirect_to new_article_path  
        end
      end
    end

    describe 'DELETE #destroy'  do
      before do
        request.env["HTTP_REFERER"] = 'redirect to back'
      end

      it 'deletes the article' do
        article
        expect{delete :destroy, id: article}.to change(Article,:count).by(-1)
      end

      it 'redirects to back' do
        delete :destroy, id: article
        expect(response).to redirect_to 'redirect to back' 
      end
    end
  end

  describe  'User does not access' do
    describe 'GET #index' do
      it 'redirects to the sign_in' do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end


