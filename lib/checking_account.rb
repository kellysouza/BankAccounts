require_relative 'account'

module Bank
  class CheckingAccount < Account

    def initialize(id, balance, timedate = nil)
      super
      @number_of_checks = 0
      @fee = 1
      @check_fee = 0
      @min_bal = -10
      check_opening_bal
    end

    def withdraw_using_check(withdrawal_amount)
      @fee = 0
      check_for_negative(withdrawal_amount)
      adjust_if_no_low_balance(withdrawal_amount)
      count_check
      charge_fee_if_appropriate(3, withdrawal_amount)
    end

    def charge_fee_if_appropriate(check_limit, withdrawal_amount)
      if @number_of_checks > check_limit && withdrawal_amount < (@balance - @min_bal)
        @check_fee = 2
        @balance -= @check_fee
      end
      return @balance
    end

    def count_check
      @number_of_checks += 1
    end

    def reset_checks
      @number_of_checks = 0
    end
  end#class CheckingAccount
end#module Bank
