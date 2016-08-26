require 'spec_helper'

describe Account::ArticlesController, :type => :controller do

  let(:user) {create(:user_with_articles, articles_count: 20)}
  login_user

  before do
    @label  = create :label
  end

  describe 'visit account article index' do
    it "renders GET index" do
      get :index
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    it "Search by label, renders index" do
      get :index, label_id: @label.id
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    it "Search by article'title, renders index" do
      get :index, search: "MyString"
      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  it "renders GET collections" do
    get :collections
    expect(response).to be_successful
    expect(response).to render_template('collections')
  end

  it "account article get calendar" do
    get :calendar
    expect(response).to be_successful
  end


  describe 'account artilce new and create' do
    it "new article" do
      get :new
      expect(response).to be_successful
      expect(response).to render_template('new')
    end

    it "create article" do
      article = Article.new attributes_for(:article)
      patch :create, article: attributes_for(:article)
      expect(response).to redirect_to(account_articles_path(type: article.article_type))
    end
  end


  describe 'account article edit and update' do
    before :each do
      @article = create :article
    end

    it 'edit article' do
      get :edit, id: @article
      expect(response).to be_successful
      expect(response).to render_template('edit')
    end

    context "valid attribute" do
      it "update article" do
        patch :update, id: @article.id, article: attributes_for(:article, title: "updateString", content: "updateContent")
        @article.reload
        expect(@article.title).to eq("updateString")
        expect(@article.content).to eq("updateContent")
        expect(response).to redirect_to(account_articles_path(type: @article.article_type))
      end
    end

    context "with invalid attributes" do
      it "update article" do
        patch :update, id: @article.id, article: attributes_for(:article, title: nil, content: "updateContent")
        @article.reload
        expect(@article.content).not_to eq("updateContent")
        expect(response).to render_template :edit
      end
    end
  end

  describe 'account article destroy' do
    before :each do
      @article = create :article
      @type = @article.article_type
    end

    it "delete the article" do
      expect{
        delete :destroy, id: @article
      }.to change(Article, :count).by(-1)
    end

    it "redirect to article#index" do
      delete :destroy, id: @article
      expect(response).to redirect_to account_articles_path(type: @type)
    end
  end

end