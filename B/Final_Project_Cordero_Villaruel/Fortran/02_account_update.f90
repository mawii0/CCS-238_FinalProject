! This module handles account information and deposit transactions.
module accounts_mod
  use iso_fortran_env, only: int64
  implicit none
  type :: account
    character(len=12) :: owner
    integer(int64) :: balance
  end type account
contains
  subroutine deposit(a, amount, ok)
    type(account), intent(inout) :: a ! Account information that will be updated.
    integer(int64), intent(in) :: amount
    logical, intent(out) :: ok

    ! Start by assuming the deposit will not be accepted.
    ok = .false.
    if (amount < 0_int64) return

    ! Make sure the balance will not exceed the allowed integer limit.
    if (a%balance > huge(a%balance) - amount) return

    ! Add the deposit to the current balance.
    a%balance = a%balance + amount
    ok = .true.
  end subroutine deposit
end module accounts_mod

program account_update
  use accounts_mod
  implicit none
  type(account) :: a
  logical :: ok_first, ok_second

  ! Set up the account with its initial balance.
  a = account('Ada', 100_int64)

  ! Try making a valid deposit and then a negative one.
  call deposit(a, 25_int64, ok_first)
  call deposit(a, -7_int64, ok_second)

  ! Display the account details and the results of both deposits.
  print '(A,A)', 'owner: ', trim(a%owner)
  print '(A,I0)', 'balance: ', a%balance
  print '(A,L1)', 'first deposit accepted: ', ok_first
  print '(A,L1)', 'negative deposit accepted: ', ok_second
end program account_update