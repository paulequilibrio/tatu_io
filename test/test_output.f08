module test_output
  use fruit
  implicit none
contains

  subroutine test_output_create_root
    use output, only: create_root
    ! character(len=:), allocatable :: argument
    ! argument = cli_get_argument(0)
    ! call assert_equals('./driver.bin', argument)
  end subroutine test_output_create_root

end module test_output
