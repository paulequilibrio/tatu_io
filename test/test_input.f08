module test_input
  use fruit
  implicit none
contains
  subroutine test_input_transmitter_model
    use input, only: json_io_input_check_transmitter_model
    integer :: i
    logical :: isvalid
    character(len=4), dimension(6) :: models
    models = (/'hedx','hedy',' ved','hmdx','hmdy',' vmd'/)
    do i=1,6
      isvalid = json_io_input_check_transmitter_model(adjustl(models(i)))
      call assert_equals(.true., isvalid)
    end do
  end subroutine test_input_transmitter_model

  subroutine test_input_direction
    use input, only: json_io_input_check_direction
    integer :: i
    logical :: isvalid
    character(len=1), dimension(3) :: direction
    direction = (/'x','y','z'/)
    do i=1,3
      isvalid = json_io_input_check_direction(direction(i))
      call assert_equals(.true., isvalid)
    end do
  end subroutine test_input_direction

  subroutine test_input_step
    use input, only: json_io_input_check_step
    use types, only: real_dp
    logical :: isvalid

    isvalid = json_io_input_check_step(0.d0,2.d0,10.d0)
    call assert_equals(.true., isvalid)

    isvalid = json_io_input_check_step(0.d0,2.d0,0.d0)
    call assert_equals(.true., isvalid)

    isvalid = json_io_input_check_step(0.d0,-2.d0,0.d0)
    call assert_equals(.true., isvalid)

    isvalid = json_io_input_check_step(10.d0,2.d0,0.d0)
    call assert_equals(.false., isvalid)

    isvalid = json_io_input_check_step(10.d0,-2.d0,0.d0)
    call assert_equals(.true., isvalid)

    isvalid = json_io_input_check_step(0.d0,-2.d0,10.d0)
    call assert_equals(.false., isvalid)
  end subroutine test_input_step

  subroutine test_input_get_type
    use input, only: json_io_input_get_type
    character(len=:), allocatable :: type

    type = json_io_input_get_type('Égua')
    call assert_equals('string', type)

    type = json_io_input_get_type(3)
    call assert_equals('integer', type)

    type = json_io_input_get_type(3.d0)
    call assert_equals('realdp', type)

  end subroutine test_input_get_type
end module
