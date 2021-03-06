require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'

require_relative '../lib/savings_account'

# Because a SavingsAccount is a kind
# of Account, and we've already tested a bunch of functionality
# on Account, we effectively get all that testing for free!
# Here we'll only test things that are different.

# TODO: change 'xdescribe' to 'describe' to run these tests
describe "SavingsAccount" do
  describe "#initialize" do
    it "Is a kind of Account" do
      # Check that a SavingsAccount is in fact a kind of account
      account = Bank::SavingsAccount.new(12345, 100.0)
      account.must_be_kind_of Bank::Account
    end

    it "Requires an initial balance of at least $10" do
      proc {
        Bank::SavingsAccount.new(1337, 9.0)
      }.must_raise ArgumentError
    end
  end

  describe "#withdraw" do
    it "Applies a $2 fee each time" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      updated_balance = account.withdraw(10)
      updated_balance.must_equal 88

    end

    it "Outputs a warning if the balance would go below $10" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      proc {
        account.withdraw(91)
      }.must_output /.+/
    end

    it "Doesn't modify the balance if it would go below $10" do
      account = Bank::SavingsAccount.new(12345, 100.0)
      updated_balance = account.withdraw(91)
      updated_balance.must_equal 100
    end

    it "Doesn't modify the balance if the fee would put it below $10" do
      start_balance = 100.0
      withdrawal_amount = 91
      account = Bank::SavingsAccount.new(1337, start_balance)
      account.withdraw(withdrawal_amount).must_equal 100
    end
  end

  describe "#add_interest" do
    it "Returns the interest calculated" do
      start_balance = 100.0
      account = Bank::SavingsAccount.new(1337, start_balance)
      account.add_interest(2.5, 1).must_equal 2.5
    end

    it "Updates the balance with calculated interest" do
      start_balance = 100.0
      account = Bank::SavingsAccount.new(1337, start_balance)
      account.add_interest(2.5, 1)
      account.balance.must_equal 102.5
    end

    it "Requires a positive rate" do
      account = Bank::SavingsAccount.new(1337, 100.0)
      proc {
        account.add_interest(0, 1)
      }.must_raise ArgumentError
    end
  end
end
