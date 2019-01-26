module json_io
  use json_module
  use types
  use input
  use output

contains

  function json_io_read_input(input_file)
    character(len=*), intent(in) :: input_file
    type(json_input) :: json_io_read_input
    call json_io_get_input(input_file, json_io_read_input)
  end function json_io_read_input

  subroutine json_io_write_output(output_file, in, labels, values, u_transmitter, u_frequency, u_receiver)
    character(len=*), intent(in) :: output_file
    type(json_input), intent(in) :: in
    character(len=*), dimension(:), intent(in) :: labels
    real(real_dp), dimension(:,:), intent(in) :: values
    real(real_dp), dimension(:,:), intent(in) :: u_transmitter
    real(real_dp), dimension(:), intent(in) :: u_frequency
    real(real_dp), dimension(:,:), intent(in) :: u_receiver
    call output_write(output_file, in, labels, values, u_transmitter, u_frequency, u_receiver)
  end subroutine json_io_write_output

end module json_io
