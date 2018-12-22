module cli
! TODO make handle cli options like version and help
! TODO write man page
contains

  function cli_get_argument(index) result(argument)
    integer, intent(in) :: index
    character(len=:), allocatable :: argument
    integer :: argument_length
    call get_command_argument(index, length=argument_length)
    allocate(character(argument_length) :: argument)
    call get_command_argument(index, value=argument)
  end function cli_get_argument

  function cli_get_option_value(option) result(value)
    character(len=*), intent(in) :: option
    character(len=:), allocatable :: argument, value
    integer :: index
    do index = 1, command_argument_count()
      argument = cli_get_argument(index)
      flag: if ( option == argument ) then
        value = cli_get_argument(index + 1)
        return
      end if flag
    end do
  end function cli_get_option_value

end module cli
