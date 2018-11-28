module test_cli
  use fruit
  implicit none
contains

  subroutine test_cli_get_argument
    use cli, only: cli_get_argument
    character(len=:), allocatable :: argument
    argument = cli_get_argument(0)
    call assert_equals('./driver.bin', argument)
  end subroutine test_cli_get_argument

  subroutine test_cli_get_option_value
    use cli, only: cli_get_option_value
    character(len=:), allocatable :: option_value
    option_value = cli_get_option_value('-i')
    call assert_equals ('./data/input.json', option_value)
    option_value = cli_get_option_value('-o')
    call assert_equals ('./data/output.json', option_value)
  end subroutine test_cli_get_option_value

end module test_cli
