module input
  use json_module
  use types

  interface json_io_get
    module procedure json_io_get_string
    module procedure json_io_get_integer
    module procedure json_io_get_real
    module procedure json_io_get_real_array
    module procedure json_io_get_real_point
  end interface json_io_get

contains

  ! IDEA Maybe create a generic interface for error
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

  subroutine path_not_found(path)
    character(len=*), intent(in) :: path
    call error('"'//path//'" not found in input file')
  end subroutine path_not_found

  ! TODO Split and separeted procedures to each input file session
  subroutine json_io_get_input(input_file, in)
    character(len=*), intent(in) :: input_file
    type(json_input), intent(out) :: in
    type(json_file) :: json

    call json%initialize()
    call json%load_file(filename = input_file)
    if (json%failed()) call error('reading error', input_file)
    ! call json%print_file()

    call json_io_get(json, 'transmitter.model', in%transmitter%model)
    call json_io_get(json, 'transmitter.direction', in%transmitter%direction)
    call json_io_get(json, 'transmitter.step', in%transmitter%step)
    call json_io_get(json, 'transmitter.final', in%transmitter%final)
    call json_io_get(json, 'transmitter.initial', in%transmitter%initial)

    call json_io_get(json, 'receiver.direction', in%receiver%direction)
    call json_io_get(json, 'receiver.step', in%receiver%step)
    call json_io_get(json, 'receiver.final', in%receiver%final)
    call json_io_get(json, 'receiver.initial', in%receiver%initial)

    call json_io_get(json, 'frequency.initial', in%frequency%initial)
    call json_io_get(json, 'frequency.samples', in%frequency%samples)
    call json_io_get(json, 'frequency.final', in%frequency%final)

    call json_io_get(json, 'layers.number', in%layers%number)
    call json_io_get(json, 'layers.resistivity', in%layers%resistivity)
    call json_io_get(json, 'layers.thickness', in%layers%thickness)

    if (size(in%layers%resistivity) /= in%layers%number) call error('The resistivity array size must be equal to layers number.')

    if (size(in%layers%thickness) /= int(in%layers%number) -1 ) then
      call error('The thickness array size must be equal to layers number minus 1.')
    end if

    call json%destroy()
    if (json%failed()) call error('error on destroy')
  end subroutine json_io_get_input


  subroutine json_io_get_string(json, path, json_io_string)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    character(len=*), intent(out) :: json_io_string
    character(len=:), allocatable :: temp
    logical :: found
    call json%get(path, temp, found)
    json_io_string = temp
    if (.not. found) call path_not_found(path)
  end subroutine json_io_get_string

  subroutine json_io_get_integer(json, path, json_io_integer)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    integer, intent(out) :: json_io_integer
    logical :: found
    call json%get(path, json_io_integer, found)
    if (.not. found) call path_not_found(path)
  end subroutine json_io_get_integer

  subroutine json_io_get_real(json, path, json_io_real)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    real(real_dp), intent(out) :: json_io_real
    logical :: found
    call json%get(path, json_io_real, found)
    if (.not. found) call path_not_found(path)
  end subroutine json_io_get_real

  subroutine json_io_get_real_array(json, path, json_io_real_array)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    real(real_dp), dimension(:), allocatable, intent(out) :: json_io_real_array
    logical :: found
    call json%get(path, json_io_real_array, found)
    if (.not. found) call path_not_found(path)
  end subroutine json_io_get_real_array

  subroutine json_io_get_real_point(json, path, json_io_real_point)
    type(json_file), intent(inout) :: json
    character(len=*), intent(in) :: path
    type(point), intent(out) :: json_io_real_point
    real(real_dp), dimension(:), allocatable :: array
    logical :: found
    call json%get(path, array, found)
    if (.not. found) call path_not_found(path)
    json_io_real_point = point(array(1), array(2), array(3))
  end subroutine json_io_get_real_point

end module input
