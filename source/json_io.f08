module json_io
  use json_module
  use types
  use input
  use output
  integer, parameter :: real_double_precision = kind(1.d0)

contains

  function json_io_read_input(input_file) ! add input file as argument
    character(len=*), intent(in) :: input_file
    type(json_input) :: json_io_read_input
    call json_io_get_input(input_file, json_io_read_input)
  end function json_io_read_input

  subroutine json_io_write_output(out)
    real(real_dp), dimension(:,:), intent(in) :: out
    call output_write(out)
  end subroutine json_io_write_output

  ! TODO put in an input module and create an output module, too.




end module json_io
