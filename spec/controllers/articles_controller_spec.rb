require 'spec_helper'

describe ArticlesController, :type => :controller do
  before(:each) do
  end

  before do
    @label = create :label
  end

  it "renders GET index" do
    get :index
    expect(response).to be_successful
    expect(response).to render_template('index')
  end

  describe 'Get Search' do
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