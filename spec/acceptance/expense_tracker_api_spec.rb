require_relative '../../app/api'
require 'rack/test'
require 'json'


def app
	ExpenseTracker::API.new
end

def post_expense(expense)
	post '/expenses', JSON.generate(expense)
	expect(last_response.status).to eq(200)
	#The include and a_kind_of matchers let us spell out in general terms what we
	# want: a hash containing a key of 'expense_id' and an integer value.
	parsed = JSON.parse(last_response.body)
	expect(parsed).to include('expense_id' => a_kind_of(Integer))
	# the call to merge at the end. This line just adds an id key to the hash, containing whatever ID
	# gets auto-assigned from the database. Doing so will make writing expectations easier later on; we’ll be able to compare for exact equality
	expense.merge('id' => parsed['expense_id'])
end

module ExpenseTracker
	RSpec.describe 'Expense Tracker API' do
		include Rack::Test::Methods

		it 'records submitted expenses' do
			pending 'Need to persist expenses'
			coffee = post_expense(
					'payee' => 'Starbucks',
					'amount' => 5.75,
					'date' => '2018-08-17'
			)
			
			zoo = post_expense(
					'payee' => 'Zoo',
					'amount' => 15.25,
					'date' => '2018-08-17'
			)
			
			groceries = post_expense(
					'payee' => 'Whole Foods',
					'amount' => 95.20,
					'date' => '2017-06-11'
			)
			
			get '/expenses/2017-06-10'
			expect(last_response.status).to eq(200)
			
			expenses = JSON.parse(last_response.body)
			expect(expenses).to contain_exactly(coffee, zoo)
		end
	end
end