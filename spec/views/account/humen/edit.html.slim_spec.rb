require 'rails_helper'

RSpec.describe "account/humen/edit", type: :view do
  before(:each) do
    @account_human = assign(:account_human, Account::Human.create!())
  end

  it "renders the edit account_human form" do
    render

    assert_select "form[action=?][method=?]", account_human_path(@account_human), "post" do
    end
  end
end
