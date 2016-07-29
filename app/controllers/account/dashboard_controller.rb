module Account
  class DashboardController < Account::AccountController
    def index
      cookies[:sidebar_active] = "dashboard"
    end
  end
end
