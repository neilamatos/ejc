class HomeController < ApplicationController
  authorize_resource class: false
  before_action :load_permissions # call this after load_and_authorize else it gives a cancan error

  def index
  end
end
