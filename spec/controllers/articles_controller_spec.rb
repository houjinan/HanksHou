require 'spec_helper'

describe ArticlesController, :type => :controller do
  before(:each) do
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

  before do
    @label = create :label
    @article = create :article
  end


  describe 'visit article index' do
    it "renders GET index" do
      get :index
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    it "Search by label, renders index" do
      get :index, params: {label_id: @label.id}
      expect(response).to be_successful
      expect(response).to render_template('index')
    end

    it "Search by article'title, renders index" do
      get :index, params: {search: "MyString"}
      expect(response).to be_successful
      expect(response).to render_template('index')
    end
  end

  it "article show" do
    get :show, params: {id: @article.id}
    expect(response).to be_successful
    expect(response).to render_template('show')
  end

  describe 'not login user to vote, collection, delete_collection' do
    it "when vote" do
      put :vote, params: {id: @article.id}
      expect(response).to redirect_to(user_session_path)
    end

    it "when collection" do
      put :collection, params: {id: @article.id}
      expect(response).to redirect_to(user_session_path)
    end

    it "when delete_collection" do
      delete :delete_collection, params: {id: @article.id}
      expect(response).to redirect_to(user_session_path)
    end
  end

  describe 'logined user to vote, collection, delete_collection' do
    let(:user) {create :user}
    login_user
    it "when vote" do
      put :vote, params: {id: @article.id}
      expect(response).to redirect_to(article_path(@article))
    end

    it "when collection" do
      put :collection, params: {id: @article.id}
      expect(response).to redirect_to(article_path(@article))
    end
  end
end