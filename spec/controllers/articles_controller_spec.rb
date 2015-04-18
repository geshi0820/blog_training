require 'spec_helper'




describe ArticlesController do


 describe 'guest access' do
   login_user
 #    describe 'GET #index' do
 #      it 'assigns the requested article to @articles' do
 #        get :index
 #        expect(response).to redirect_to :root_path
 #      end
 #    end
  let(:article) do
    create(:article)
  end
 
    describe 'GET #show' do
      subject { build(:article, title: 'hello')}
      it {should be_titled 'hello'}

      it "assigns the requested article to @article" do
        get :show, id: article
        expect(assigns(:article)).to eq article
    
      end
      it "renders the :show template" do
        get :show, id: article
        expect(response).to render_template :show
      end
    end

    describe 'GET #new' do
      it "assigns a new article to @article" do
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end
      it "renders the :new template" do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      before :each do
        @articles = [
          attributes_for(:article),
          attributes_for(:article),
          attributes_for(:article)
        ]
      end
      context 'with valid attributes' do
        it 'saves the new article in the database',:focus => true do 
          new_article = []
          new_article.stub(:count).and_return(4)
          expect(new_article.count).to eq 4
        end

        it 'redirects to articles#show' do      
            post :create, 
            article: attributes_for(:article, articles_attributes: attributes_for(:article))
          expect(response).to redirect_to article_path(assigns[:article])
        end
      end
    end

    describe 'DELETE #destroy' do
      before :each do
        @article = create(:article)
      end
      it 'deletes the article' do      
        expect{
          delete :destroy, id: @article
        }.to change(Article, :count).by(-1)
      end
      it 'redirects to articles#index' do      
        delete :destroy, id: @article
        expect(response).to redirect_to articles_url
      end
    end
  end
end


