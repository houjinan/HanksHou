module Account
  class AccountController < ApplicationController
    before_action :authenticate_user!
    layout 'account_layout'

    private
  end
end
