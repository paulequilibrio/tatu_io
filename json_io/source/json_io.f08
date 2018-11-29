module json_io
  use cli
  use file
  use input_types
  use json_module
  implicit none

contains

  module subroutine json_io_get_input(inputs)
    type(input), intent(out) :: inputs
    character(len=:), allocatable :: input_json, output_json
    type(json_file) :: json
    write(*,*) 'Command line options:'
    input_json = cli_get_option_value('-i')
    write(*,*) '  -i: '//input_json
    output_json = cli_get_option_value('-o')
    write(*,*) '  -o: '//output_json
  end subroutine json_io_get_input

  module subroutine json_io_open(filepath, fileunit)
    character(len=*), intent(in) :: filepath
    integer, intent(out) :: fileunit
    logical :: exist, readable
    integer :: open_status
    character(len=:), allocatable :: open_error

    exist = file_already_exist(filepath)
    not_exist: if (.not. exist) then
      call error("No such file '"//filepath//"'")
    end if not_exist

    readable = file_is_readable(filepath)
    not_readable: if (.not. readable) then
      call error("No permission to read file '"//filepath//"'")
    end if not_readable

    open ( &
      newunit=fileunit &
      ,file=trim(adjustl(filepath)) &
      ,status='old' &
      ,action='read' &
      ,iostat=open_status &
      ,iomsg=open_error &
      ,decimal='point' &
      ,access='sequential' &
      ,form='formatted' &
      ,position='rewind' &
    )

    if ( open_status /= 0 ) call error(open_error)
  end subroutine json_io_open



  module function json_io_get_option(option) result(value)
    character(len=*), intent(in) :: option
    character(len=:), allocatable :: value
    value = cli_get_option_value(option)
    write(*,*) '  -i: '//value
  end function json_io_get_option

  module subroutine error(message)
    character(len=*), intent(in) :: message
    write(*, '(A)') message
    stop
  end subroutine



end module json_io
