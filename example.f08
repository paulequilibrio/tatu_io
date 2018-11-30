program example
  use json_io
  implicit none

  type(input) :: inputs
  inputs = read_input()

  write(*,*) 'SOURCE'
  write(*,*) '  model: ', inputs%source%model
  write(*,*) '  direction: ', inputs%source%direction
  write(*,*) '  initial: ', inputs%source%initial
  write(*,*) '  step: ', inputs%source%step
  write(*,*) '  final: ', inputs%source%final

  write(*,*) 'RECEIVER'
  write(*,*) '  direction: ', inputs%receiver%direction
  write(*,*) '  initial: ', inputs%receiver%initial
  write(*,*) '  step: ', inputs%receiver%step
  write(*,*) '  final: ', inputs%receiver%final

  write(*,*) 'FREQUENCY'
  write(*,*) '  initial: ', inputs%frequency%initial
  write(*,*) '  samples: ', inputs%frequency%samples
  write(*,*) '  final: ', inputs%frequency%final

  write(*,*) 'LAYERS'
  write(*,*) '  number: ', inputs%layers%number
  write(*,*) '  resistivity: ', inputs%layers%resistivity
  write(*,*) '  thickness: ', inputs%layers%thickness

  ! ! call core%initialize()
  ! call core%create_object(output, '')
  ! ! call core%add(output, str)
  ! call core%add(output, 'frequency', 12)
  ! call core%print(output, 'data/output.json')
  ! call core%destroy(output)
  !
  ! ! open(newunit=fileunit, file='data/output.json')
  ! ! call json%print_file(fileunit)
  !
  ! ! clean up
  ! call json%destroy()
  ! if (json%failed()) stop -1

end program example
