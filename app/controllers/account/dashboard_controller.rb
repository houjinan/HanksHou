module Account
  class DashboardController < Account::AccountController
    def index
      cookies[:sidebar_active] = "dashboard"
    end

    def unauthorized_error

    end
  end
end
