module json_io
  use cli
  use file
  use input_types
  use json_module

contains

  subroutine error(message, filename)
    character(len=*), intent(in) :: message
    character(len=*), intent(in), optional :: filename
    if (present(filename)) then
      write(*, '(A)') filename//': '//message
    else
      write(*, '(A)') message
    end if
    stop
  end subroutine

  function read_input()
    type(input) :: read_input
    call json_io_get_input(read_input)
  end function read_input

  ! TODO put in an input module and create an output module, too.
  subroutine json_io_get_input(in)
    type(input), intent(out) :: in
    type(json_file) :: json
    character(len=:), allocatable :: input_file
    real(real_dp), dimension(:), allocatable :: array

    input_file = cli_get_option_value('-i')

    call json%initialize()
    call json%load_file(filename = input_file)
    if (json%failed()) call error('reading error', input_file)

    in%transmitter%model = get_string(json, 'transmitter.model')
    in%transmitter%direction = get_string(json, 'transmitter.direction')
    in%transmitter%step = get_real(json, 'transmitter.step')
    in%transmitter%final = get_real(json, 'transmitter.final')
    array = get_array(json, 'transmitter.initial')
    in%transmitter%initial = point(array(1), array(2), array(3))

    in%receiver%direction = get_string(json, 'receiver.direction')
    in%receiver%step = get_real(json, 'receiver.step')
    in%receiver%final = get_real(json, 'receiver.final')
    array = get_array(json, 'receiver.initial')
    in%receiver%initial = point(array(1), array(2), array(3))

    in%frequency%initial = get_real(json, 'frequency.initial')
    in%frequency%samples = get_real(json, 'frequency.samples')
    in%frequency%final = get_real(json, 'frequency.final')

    in%layers%number = get_real(json, 'layers.number')
    in%layers%resistivity = get_array(json, 'layers.resistivity')
    in%layers%thickness = get_array(json, 'layers.thickness')

    if (size(in%layers%resistivity) /= in%layers%number) call error('The resistivity array size must be equal to layers number.')

    if (size(in%layers%thickness) /= int(in%layers%number) -1 ) then
      call error('The thickness array size must be equal to layers number minus 1.')
    end if

    call json%destroy()
    if (json%failed()) call error('error on destroy')

  end subroutine json_io_get_input

  ! Try to create a generic interface get
  function get_string(json, path)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    character(len=:), allocatable :: get_string
    logical :: found
    call json%get(path, get_string, found)
    if (.not. found) call error('"'//path//'" not found in input file')
  end function get_string

  function get_real(json, path)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    real(real_dp) :: get_real
    logical :: found
    call json%get(path, get_real, found)
    if (.not. found) call error('"'//path//'" not found in input file')
  end function get_real

  function get_array(json, path)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    real(real_dp), dimension(:), allocatable :: get_array
    logical :: found
    call json%get(path, get_array, found)
    if (.not. found) call error('"'//path//'" not found in input file')
  end function get_array

end module json_io
