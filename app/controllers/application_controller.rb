class ApplicationController < ActionController::Base
  after_action :avoid_caching_js

  private

  def avoid_caching_js
    if request.xhr?
      response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
      response.headers['Pragma'] = 'no-cache'
      response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
    end
  end
end
