program example
  use json_io
  implicit none

  type(input) :: inputs
  type(json_file) :: json
  type(json_core) :: core
  type(json_value), pointer :: output
  logical :: found
  character(len=:), allocatable :: source_model, source_direction, receiver_direction
  character(len=:), allocatable :: input_file
  integer, parameter :: sp = kind(1.e0)
  integer, parameter :: dp = kind(1.d0)
  real(dp) :: source_step, source_final
  real(dp), allocatable :: source_initial(:)
  integer :: fileunit
  character(len=:), allocatable :: str

  call json_io_get_input(inputs)
  write(*,*) inputs

  ! initialize the class
  call json%initialize()

  ! read the file
  call json%load_file(filename = 'data/input.json')

  ! print the file to the console
  ! call json%print_file()

  ! extract data from the file
  ! [found can be used to check if the data was really there]
  call json%get('source.model', source_model, found)
  if ( .not. found ) stop 1
  call json%get('source.direction', source_direction, found)
  if ( .not. found ) stop 2
  call json%get('source.step', source_step, found)
  if ( .not. found ) stop 3
  call json%get('source.final', source_final, found)
  if ( .not. found ) stop 4
  call json%get('source.initial', source_initial, found)
  if ( .not. found ) stop 5

  write(*, '(2a)') 'source_model: ', source_model
  write(*, '(2a)') 'source_direction: ', source_direction
  write(*, '(a,f16.8)') 'source_step:   ', source_step
  write(*, '(a,f16.8)') 'source_final:  ', source_final
  write(*, '(a,3f16.8)') 'source_initial:', source_initial

  ! call json%print_to_string(str)
  ! write(*,*) str
  ! print output file
  ! call core%initialize()
  call core%create_object(output, '')
  ! call core%add(output, str)
  call core%add(output, 'frequency', 12)
  call core%print(output, 'data/output.json')
  call core%destroy(output)

  ! open(newunit=fileunit, file='data/output.json')
  ! call json%print_file(fileunit)

  ! clean up
  call json%destroy()
  if (json%failed()) stop -1

end program example
