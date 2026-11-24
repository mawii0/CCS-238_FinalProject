! This module contains the subroutine used to calculate basic statistics
! from an array of integer values.
module vector_stats_mod
  use iso_fortran_env, only: real64
  implicit none
contains
  subroutine summarize(values, mean_value, maximum, ok)
    integer, intent(in) :: values(:) ! Array of values to be processed.
    real(real64), intent(out) :: mean_value
    integer, intent(out) :: maximum
    logical, intent(out) :: ok

    ! Check if the array is empty before performing calculations.
    if (size(values) == 0) then
      mean_value = 0.0_real64
      maximum = 0
      ok = .false.
      return
    end if

    ! Calculate the average and find the highest value in the array.
    mean_value = real(sum(values), real64) / real(size(values), real64)
    maximum = maxval(values)
    ok = .true.
  end subroutine summarize
end module vector_stats_mod

program vector_stats
  use vector_stats_mod
  implicit none
  integer :: values(5) = [4, 7, 2, 9, 3]
  real(real64) :: mean_value
  integer :: maximum
  logical :: ok

  ! Get the statistics for the given array.
  call summarize(values, mean_value, maximum, ok)

  ! Stop the program if the input array is empty.
  if (.not. ok) error stop 'unexpected empty input'

  ! Display the total number of values, their average, and the maximum.
  print '(A,I0)', 'count: ', size(values)
  print '(A,F0.2)', 'mean: ', mean_value
  print '(A,I0)', 'maximum: ', maximum
end program vector_stats