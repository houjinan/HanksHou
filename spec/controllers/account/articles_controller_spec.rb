require 'spec_helper'

describe Account::ArticlesController, :type => :controller do
  # before(:each) do
  #   # sign_out :user
  #   # @user ||= create :user
  # end
  let(:user) {create(:user_with_articles, articles_count: 20)}
  login_user 

  before do
    @label  = create :label
    # allow(controller).to receive_messages(
    #   current_user: user
    #   )
  end
    
  describe 'Get Search' do
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
end 