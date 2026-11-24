program parse_totals
  implicit none
  character(len=8) :: tokens(5) = [character(len=8) :: &
      '12', 'oops', '7', '-3', '25']
  integer :: i, value, io_status, accepted, rejected, total

  ! Initialize the counters and total before processing the values.
  accepted = 0
  rejected = 0
  total = 0

  ! Go through each entry and try to convert it into an integer.
  do i = 1, size(tokens)
    read(tokens(i), *, iostat=io_status) value

    ! Add valid numbers to the total and count invalid entries separately.
    if (io_status == 0) then
      accepted = accepted + 1
      total = total + value
    else
      rejected = rejected + 1
    end if
  end do

  ! Display the number of accepted and rejected entries and their total.
  print '(A,I0)', 'accepted: ', accepted
  print '(A,I0)', 'rejected: ', rejected
  print '(A,I0)', 'total: ', total
end program parse_totals