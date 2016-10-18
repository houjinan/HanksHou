require 'rails_helper'

RSpec.describe "account/humen/index", type: :view do
  before(:each) do
    assign(:account_humen, [
      Account::Human.create!(),
      Account::Human.create!()
    ])
  end

  it "renders a list of account/humen" do
    render
  end
end
