Rails.application.routes.draw do

  mount Converter::Currency => '/api'

end
