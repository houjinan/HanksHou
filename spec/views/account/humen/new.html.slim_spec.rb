require 'rails_helper'

RSpec.describe "account/humen/new", type: :view do
  before(:each) do
    assign(:account_human, Account::Human.new())
  end

  it "renders new account_human form" do
    render

    assert_select "form[action=?][method=?]", account_humen_path, "post" do
    end
  end
end
