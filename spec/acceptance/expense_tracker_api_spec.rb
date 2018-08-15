require 'rack/test'
require 'json'

module ExpenseTracker
	RSpec.describe 'Expense Tracker API' do
		include Rack::Test::method
		
		it 'recoords submitted expenses' do
			coffe = {
					'payee' => 'Starbuck',
					'amount' => 5.75,
					'date' => '2018-06-10'
			}
			
			post '/expenses', JSON.generate(coffee)
		end
	end
end