class AnalyticsController < ApplicationController
    def index
      @user_queries = Query.where(ip_address: request.remote_ip)
    end
  end