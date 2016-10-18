require 'rails_helper'

RSpec.describe "account/humen/show", type: :view do
  before(:each) do
    @account_human = assign(:account_human, Account::Human.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
