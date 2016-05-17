class StaticController < ApplicationController
  skip_before_action :set_current_user
  layout false
end
