require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/account'

describe "Wave 1" do
  describe "Account#initialize" do
    it "Takes an ID and an initial balance" do
      id = 1337
      balance = 100.0
      account = Bank::Account.new(id, balance)

      account.must_respond_to :id
      account.id.must_equal id

      account.must_respond_to :balance
      account.balance.must_equal balance
    end

    it "Raises an ArgumentError when created with a negative balance" do
      # Note: we haven't talked about procs yet. You can think
      # of them like blocks that sit by themselves.
      # This code checks that, when the proc is executed, it
      # raises an ArgumentError.
      proc {
        Bank::Account.new(1337, -100.0)
      }.must_raise ArgumentError
    end

    it "Can be created with a balance of 0" do
      # If this raises, the test will fail. No 'must's needed!
      Bank::Account.new(1337, 0)
    end
  end

  describe "Account#withdraw" do
    it "Reduces the balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance)

      account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      withdrawal_amount = 25.0
      account = Bank::Account.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      expected_balance = start_balance - withdrawal_amount
      updated_balance.must_equal expected_balance
    end

    it "Outputs a warning if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance)

      # Another proc! This test expects something to be printed
      # to the terminal, using 'must_output'. /.+/ is a regular
      # expression matching one or more characters - as long as
      # anything at all is printed out the test will pass.
      proc {
        account.withdraw(withdrawal_amount)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if the account would go negative" do
      start_balance = 100.0
      withdrawal_amount = 200.0
      account = Bank::Account.new(1337, start_balance)

      updated_balance = account.withdraw(withdrawal_amount)

      # Both the value returned and the balance in the account
      # must be un-modified.
      updated_balance.must_equal start_balance
      account.balance.must_equal start_balance
    end

    it "Allows the balance to go to 0" do
      account = Bank::Account.new(1337, 100.0)
      updated_balance = account.withdraw(account.balance)
      updated_balance.must_equal 0
      account.balance.must_equal 0
    end

    it "Requires a positive withdrawal amount" do
      start_balance = 100.0
      withdrawal_amount = -25.0
      account = Bank::Account.new(1337, start_balance)

      proc {
        account.withdraw(withdrawal_amount)
      }.must_raise ArgumentError
    end
  end

  describe "Account#deposit" do
    it "Increases the balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance)

      account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      account.balance.must_equal expected_balance
    end

    it "Returns the modified balance" do
      start_balance = 100.0
      deposit_amount = 25.0
      account = Bank::Account.new(1337, start_balance)

      updated_balance = account.deposit(deposit_amount)

      expected_balance = start_balance + deposit_amount
      updated_balance.must_equal expected_balance
    end

    it "Requires a positive deposit amount" do
      start_balance = 100.0
      deposit_amount = -25.0
      account = Bank::Account.new(1337, start_balance)

      proc {
        account.deposit(deposit_amount)
      }.must_raise ArgumentError
    end
  end




#   describe "Account#owner" do
#     it "requires name and dob" do
#       name = "Kelly Souza"
#       dob = "02/05/1978"
#       address = {
#         street1: "1221 N. Fife",
#         street2: "#4",
#         city: "Tacoma",
#         state: "WA",
#         zip: "98406"
#       }
#       owner = Bank::Owner.new(name, dob, address)
#       owner.name.must_equal name
#       owner.dob.must_equal dob
#       owner.address.must_equal address
#     end #end require name and dob
# end
    # it "requires owner address" do
      # street1 = "1221 N. Fife",
      # street2 = "#4",
      # city = "Tacoma",
      # state = "WA",
      # zip = "98406"
      # owner.address.must_equal address
  #
  #
  # # end

  #end

  #end "Account#owner"


end




# TODO: change 'xdescribe' to 'describe' to run these tests
describe "Wave 2" do
  describe "Account.all" do
    it "Returns an array of all accounts" do
      # TODO: Your test code here!
      # Useful checks might include:
      account_array = Bank::Account.all
      account_array.class.must_equal Array
      # #   - The number of accounts is correct
      # account_array.class.must_equal Array
      account_array.length.must_equal 12
      # #   - Everything in the array is an Account
      account_array.each {|account| account.class.must_equal Bank::Account}
      #   - The ID and balance of the first and last
      #       accounts match what's in the CSV file

      # account_array[0]
      # Feel free to split this into multiple tests if needed
    end
  end

  xdescribe "Account.find" do
    it "Returns an account that exists" do
      # TODO: Your test code here!
    end

    it "Can find the first account from the CSV" do
      # TODO: Your test code here!
    end

    it "Can find the last account from the CSV" do
      # TODO: Your test code here!
    end

    it "Raises an error for an account that doesn't exist" do
      # TODO: Your test code here!
    end
  end
end
