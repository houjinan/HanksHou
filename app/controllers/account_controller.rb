class AccountController < ApplicationController
  before_action :authenticate_user!
  layout 'account_layout'


end
