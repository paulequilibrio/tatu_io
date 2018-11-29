module json_io
  use cli
  use file
  use input_types
  use json_module
  implicit none

contains

  module subroutine error(message, filename)
    character(len=*), intent(in) :: message
    character(len=*), intent(in), optional :: filename
    if (present(filename)) then
      write(*, '(A)') filename//': '//message
    else
      write(*, '(A)') message
    end if
    stop
  end subroutine

  module function read_input()
    type(input) :: read_input
    call json_io_get_input(read_input)
  end function read_input

  module subroutine json_io_get_input(in)
    type(input), intent(out) :: in
    type(point) :: initial
    type(source) :: transmitter
    type(json_file) :: json
    character(len=:), allocatable :: input_file, tempstr, name
    real(kind(0d0)) :: tempreal
    logical :: found

    ! transmitter = source('', '', point(0, 0, 0), 0, 0)
    ! in = input(transmitter)

    input_file = cli_get_option_value('-i')

    call json%initialize()
    call json%load_file(filename = input_file)

    ! call json%get('source.model', tempstr, found)
    ! name = 'model'
    ! if (found) then
    !   in%source%model = tempstr
    ! else
    !   call error('source.model not found', input_file)
    ! end if

    call json%get('source.direction', tempstr, found)
    if (found) then
      in%source%direction = tempstr
    else
      call error('source.direction not found', input_file)
    end if

    call json%get('source.step', tempreal, found)
    if (found) then
      in%source%step = tempreal
    else
      call error('source.step not found', input_file)
    end if

    call json%get('source.final', tempreal, found)
    if (found) then
      in%source%final = tempreal
    else
      call error('source.final not found', input_file)
    end if

    call json%get('source.initial[1]', tempreal, found)
    if (found) then
      in%source%initial%x = tempreal
    else
      call error('source.initial.x not found', input_file)
    end if

    call json%get('source.initial[2]', tempreal, found)
    if (found) then
      in%source%initial%y = tempreal
    else
      call error('source.initial.y not found', input_file)
    end if

    call json%get('source.initial[3]', tempreal, found)
    if (found) then
      in%source%initial%z = tempreal
    else
      call error('source.initial.z not found', input_file)
    end if

    in%source%model = get_string(json, 'source.model')
    write(*,*) in%source%model

    ! initial = point(8d-1, 6d-1, 4d-1)
    ! transmitter = source('dehx', 'x', initial, 3d-1, 9d0)
    ! in = input(transmitter)

    ! initialize the class

    ! write(*,*) input_file
    ! read the file

    ! print the file to the console
    ! call json%print_file()
    ! call json%get('source.model', in%source%model, found)
    ! write(*,*) '  -i: '//cli_get_option_value('-i')

    call json%destroy()
    if (json%failed()) stop -1

  end subroutine json_io_get_input


  module function get_string(json, path)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    character(len=:), allocatable :: get_string, temp
    logical :: found
    call json%get(path, temp, found)
    if (found) then
      get_string = temp
    else
      call error('"'//path//'" not found in input file')
    end if
  end function get_string

end module json_io
