program example

  use json_module

  implicit none

  type(json_file) :: json
  logical :: found
  character(len=:), allocatable :: source_type, source_direction, receiver_direction
  real :: source_step, source_final
  real, allocatable :: source_initial(:)

  ! initialize the class
  call json%initialize()

  ! read the file
  call json%load_file(filename = 'config.json')

  ! print the file to the console
  call json%print_file()

  ! extract data from the file
  ! [found can be used to check if the data was really there]
  call json%get('source.type', source_type, found)
  if ( .not. found ) stop 1
  call json%get('version.minor', j, found)
  if ( .not. found ) stop 2
  call json%get('data(1).number', k, found)
  if ( .not. found ) stop 3

  write(*, '(2a)') 'source_type: ', source_type
  write(*, '(2a)') 'source_direction: ', source_direction
  write(*, '(a,f12.8)') 'source_step:   ', source_step
  write(*, '(a,f12.8)') 'source_final:  ', source_final
  write(*, '(a,3f12.8)') 'source_initial:', source_initial

  ! clean up
  call json%destroy()
  if (json%failed()) stop -1

end program example
