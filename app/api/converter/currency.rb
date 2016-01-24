module Converter
	class Currency < Grape::API
		version 'v1', using: :path
		format :json
		rescue_from :all
		# Pick Up Here!
		error_formatter :json, lambda { |message, backtrace, options, env|
			{
				status: 'failed',
				message: message,
				error_code: 123
			}
		}
		helpers do
			def get_exchange_rate(currency)
				case currency
				when 'NTD'
					30
				else
					# ERROR HANDLING
					# Probably want Status Code and/or Success or Failure Message
					raise StandardError.new "no conversion found for currency '#{currency}' "
				end
			end

		end

		resource :converter do
			params do
				requires :amount, type: Float
				requires :to_currency, type: String
			end

			get :exchange do
				converted_amount = params[:amount] * get_exchange_rate(params[:to_currency])
				#Hash to actually RETURN Value
				{
					amount: converted_amount,
					currency: params[:to_currency]
				}
			end
		
		end
	end
end