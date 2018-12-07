module output
  use json_module
  use types

contains

  ! function create_root(variables)
  ! end function create_root

  subroutine output_write(out)
    real(real_dp), dimension(:,:), intent(in) :: out
    type(json_output) :: json
    write(*,*) out(1,:)
  end subroutine output_write

  ! ! call core%initialize()
  ! call core%create_object(output, '')
  ! ! call core%add(output, str)
  ! call core%add(output, 'frequency', 12)
  ! call core%print(output, 'data/output.json')
  ! call core%destroy(output)
  ! call json%destroy()
  ! if (json%failed()) call error('error on destroy')
end module output
