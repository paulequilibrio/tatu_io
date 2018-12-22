module output
  use json_module
  use types
  private
  public output_write

contains

  subroutine output_write(output_file, in, labels, values)
    character(len=*), intent(in) :: output_file
    type(json_input), intent(in) :: in
    character(len=*), dimension(:), intent(in) :: labels
    real(real_dp), dimension(:,:), intent(in) :: values

    type(json_core) :: core
    type(json_value), pointer :: root, input, output

    write(*,*) '[ INFO ] Creating output...'
    call core%initialize()
    call core%create_object(root, '')

    call core%create_object(input, 'input')
    call core%add(root, input)
    call write_input(in, input)

    call core%create_object(output, 'output')
    call core%add(root, output)
    call write_output(output, labels, values)
    call core%print(root, trim(adjustl(output_file)))
    write(*,*) '[ DONE ] Output created'

    call core%destroy(root)
    if (core%failed()) stop 'Error on destroy output root'
    ! if (core%failed()) call error('error on destroy')
  end subroutine output_write


  subroutine write_input(in, input)
    type(json_input), intent(in) :: in
    type(json_value), pointer, intent(in) :: input
    call write_input_transmitter(in, input)
    call write_input_receiver(in, input)
    call write_input_frequency(in, input)
    call write_input_layers(in, input)
  end subroutine write_input

  subroutine write_output(output, labels, values)
    type(json_value), pointer, intent(in) :: output
    character(len=*), dimension(:), intent(in) :: labels
    real(real_dp), dimension(:,:), intent(in) :: values
    call write_output_labels(output, labels)
    call write_output_values(output, values)
  end subroutine write_output


  subroutine write_input_transmitter(in, input)
    type(json_input), intent(in) :: in
    type(json_value), pointer, intent(in) :: input
    type(json_core) :: core
    type(json_value), pointer :: transmitter_
    type(point) :: p
    call core%create_object(transmitter_, 'transmitter')
    call core%add(input, transmitter_)
    call core%add(transmitter_, 'model', in%transmitter%model)
    call core%add(transmitter_, 'direction', in%transmitter%direction)
    p = in%transmitter%initial
    call core%add(transmitter_, 'initial', [p%x, p%y, p%z])
    call core%add(transmitter_, 'step', in%transmitter%step)
    call core%add(transmitter_, 'final', in%transmitter%final)
    nullify(transmitter_)
  end subroutine write_input_transmitter

  subroutine write_input_receiver(in, input)
    type(json_input), intent(in) :: in
    type(json_value), pointer, intent(in) :: input
    type(json_core) :: core
    type(json_value), pointer :: receiver_
    type(point) :: p
    call core%create_object(receiver_, 'receiver')
    call core%add(input, receiver_)
    call core%add(receiver_, 'direction', in%receiver%direction)
    p = in%receiver%initial
    call core%add(receiver_, 'initial', [p%x, p%y, p%z])
    call core%add(receiver_, 'step', in%receiver%step)
    call core%add(receiver_, 'final', in%receiver%final)
    nullify(receiver_)
  end subroutine write_input_receiver

  subroutine write_input_frequency(in, input)
    type(json_input), intent(in) :: in
    type(json_value), pointer, intent(in) :: input
    type(json_core) :: core
    type(json_value), pointer :: frequency_
    call core%create_object(frequency_, 'frequency')
    call core%add(input, frequency_)
    call core%add(frequency_, 'initial', in%frequency%initial)
    call core%add(frequency_, 'samples', in%frequency%samples)
    call core%add(frequency_, 'final', in%frequency%final)
    nullify(frequency_)
  end subroutine write_input_frequency

  subroutine write_input_layers(in, input)
    type(json_input), intent(in) :: in
    type(json_value), pointer, intent(in) :: input
    type(json_core) :: core
    type(json_value), pointer :: layers_
    call core%create_object(layers_, 'layers')
    call core%add(input, layers_)
    call core%add(layers_, 'number', in%layers%number)
    call core%add(layers_, 'resistivity', in%layers%resistivity)
    call core%add(layers_, 'thickness', in%layers%thickness)
    nullify(layers_)
  end subroutine write_input_layers


  subroutine write_output_labels(output, labels)
    type(json_value), pointer, intent(in) :: output
    character(len=*), dimension(:), intent(in) :: labels
    type(json_core) :: core
    logical(json_LK) :: found
    integer :: int_index, limit
    type(json_value), pointer :: element, new
    character(len=10) :: index
    call core%add(output, 'labels', [trim(labels(1))])
    limit = size(labels) - 1
    do int_index = 1, limit
      write(index , '(i2)') int_index
      call core%get(output, 'labels('//index//')', element, found)
      call core%create_string(new, trim(labels(int_index+1)), '')
      call core%insert_after(element, new)
    end do
  end subroutine write_output_labels

  subroutine write_output_values(output, values)
    type(json_value), pointer, intent(in) :: output
    real(real_dp), dimension(:,:), intent(in) :: values
    type(json_core) :: core
    integer, dimension(2) :: values_shape
    integer :: index, limit
    type(json_value), pointer :: array
    call core%create_array(array, 'values')
    call core%add(output, array)
    values_shape = shape(values)
    limit = values_shape(1)
    do index = 1, limit
      call core%add(array, '', values(index,:))
    end do
  end subroutine write_output_values

end module output
