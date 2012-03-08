class Admin::BaseController < ApplicationController
  layout 'admin'

  before_filter :check_authorized

  private
    def check_authorized
      authorize! :admin, :all
    end
end
