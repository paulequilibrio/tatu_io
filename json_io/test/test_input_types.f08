module test_input_types
  use fruit
  implicit none
contains

  subroutine test_input_types_point
    use input_types, only: point
    type(point) :: initial = point(1d0, 2d0, 3d0)
    call assert_equals(1d0, initial%x)
    call assert_equals(2d0, initial%y)
    call assert_equals(3d0, initial%z)
  end subroutine test_input_types_point

  subroutine test_input_types_source
    use input_types, only: point, source
    type(point) :: initial
    type(source) :: transmitter
    initial = point(-3d0, -2d0, -1d0)
    transmitter = source('dehx', 'x', initial, 5d-1, 4d0)
    call assert_equals('dehx', transmitter%model)
    call assert_equals('x', transmitter%direction)
    call assert_equals(-3d0, transmitter%initial%x)
    call assert_equals(-2d0, transmitter%initial%y)
    call assert_equals(-1d0, transmitter%initial%z)
    call assert_equals(5d-1, transmitter%step)
    call assert_equals(4d0, transmitter%final)
  end subroutine test_input_types_source

  subroutine test_input_types_input
    use input_types
    type(point) :: initial
    type(source) :: src
    type(input) :: in
    initial = point(8d-1, 6d-1, 4d-1)
    src = source('dehx', 'x', initial, 3d-1, 9d0)
    in = input(src)
    call assert_equals('dehx', in%source%model)
    call assert_equals('x', in%source%direction)
    call assert_equals(8d-1, in%source%initial%x)
    call assert_equals(6d-1, in%source%initial%y)
    call assert_equals(4d-1, in%source%initial%z)
    call assert_equals(3d-1, in%source%step)
    call assert_equals(9d0, in%source%final)
  end subroutine test_input_types_input

end module test_input_types
