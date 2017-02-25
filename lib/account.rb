# Create a class inside of a module
# Create methods inside the class to perform actions
# Learn how Ruby does error handling
# Verify code correctness by testing
require 'csv'
require 'awesome_print'


module Bank
  class Account
    attr_accessor :id, :balance, :timedate

    def initialize(id, balance, timedate = nil)
      @min_bal = 0
      raise ArgumentError.new("balance must be greater than zero") if balance < @min_bal
      @id = id
      @balance = balance
      @timedate = timedate
      @fee = 0
    end

    def self.all
      account_array = []
      CSV.read("support/accounts.csv").each do |account|
        account_array << (Account.new(account[0], account[1].to_i/100.0, account[2]))
      end
      account_array
    end

    # self.find(id) - returns an instance of Account
    # where the value of the id field in the CSV matches
    # the passed parameter.

    def self.find(id)
      account_array = Bank::Account.all
      account_array.each do |account|
        if id == account.id
          return account
        end
      end
      raise ArgumentError.new "Account #{id} does not exist"
    end



    def withdraw(withdrawal_amount)
      check_for_negative(withdrawal_amount)
      if withdrawal_amount > (@balance - @min_bal)
        puts "Warning low balance!"
      else
        @balance -= (withdrawal_amount + @fee)
      end
      return @balance
    end

    def deposit(deposit_amount)
      raise ArgumentError.new "You must deposit an amount" if deposit_amount < 0
      @balance += deposit_amount
    end


    def check_for_negative(withdrawal_amount)
      raise ArgumentError.new "You cannot withdraw a negative amount" if withdrawal_amount < 0
    end
  end #end class Account
  # class Owner
  #   attr_accessor :lastname, :firstname,
  #
  #    def initialize(lastname, firstname, street, city, state)
  #      @lastname = lastname
  #      @firstname = firstname
  #      @street = street
  #      @city = city
  #      @state = state
  #
  #
  #    end
  # end #end owner class
end #end module Bank
