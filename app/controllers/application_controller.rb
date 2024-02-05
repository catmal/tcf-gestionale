class ApplicationController < ActionController::Base
  def current_company
    Company.find_by(name: 'TCF')
  end

  def current_client
    Company.find_by(name: 'IMA')
  end
end
