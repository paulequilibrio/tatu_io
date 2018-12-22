module types
  integer, parameter :: real_dp = kind(1.d0)

  type :: point
    real(real_dp) :: x
    real(real_dp) :: y
    real(real_dp) :: z
  end type point

  type :: transmitter
    character(5) :: model
    character :: direction
    type(point) initial
    real(real_dp) :: step
    real(real_dp) :: final
  end type transmitter

  type :: receiver
    character :: direction
    type(point) initial
    real(real_dp) :: step
    real(real_dp) :: final
  end type receiver

  type :: frequency
    integer :: samples
    real(real_dp) :: initial
    real(real_dp) :: final
  end type frequency

  type :: layers
    integer :: number
    real(real_dp), dimension(:), allocatable :: resistivity
    real(real_dp), dimension(:), allocatable :: thickness
  ! contains
  !   generic :: write => write_layers
  !   procedure :: write_layers
  end type layers

  type :: json_input
    type(transmitter) :: transmitter
    type(receiver) :: receiver
    type(frequency) :: frequency
    type(layers) :: layers
  end type json_input

  type :: json_output
    type(json_input) :: input
    character(:), dimension(:), allocatable :: labels
    real(real_dp), dimension(:), allocatable :: values
  end type json_output

! contains
!   subroutine write_layers(this)
!     class(layers), intent(in) :: this
!      write(*,*) this%number, SIZE(this%resistivity), SIZE(this%thickness)
!   end subroutine write_layers

end module types
