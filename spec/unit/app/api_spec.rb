require_relative '../../../app/api'
require 'rack/test'

module ExpenseTracker
	RecordResult = Struct.new(:success?, :expense_id, :error_message)
  RSpec.describe API do
	  include Rack::Test::Methods
	  
	  def app
		  API.new(ledger: ledger)
	  end
	  # A test double is an object that stands in for another one during a test. Testers
	  # tend to refer to them as mocks, stubs, fakes, or spies, depending on how they are used.
	  let(:ledger) { instance_double('ExpenseTracker::Ledger') }
	  
    describe 'POST /expenses' do
      context 'when the expense is successfully recorded' do
        it 'returns the expense id' do expense = { 'some' => 'data' }
          allow(ledger).to receive(:record)
          .with(expense)
          .and_return(RecordResult.new(true, 417, nil))
        post '/expenses', JSON.generate(expense)
        parsed = JSON.parse(last_response.body)
        expect(
        
        it 'responds with a 200 (OK)'
      end


      context 'when the expense fails validation' do
        it 'returns an error message'
        it 'responds with a 422 (Unprocessable entity)'
      end
    end
  end
end