module input_types
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
    real(real_dp) :: initial
    real(real_dp) :: samples
    real(real_dp) :: final
  end type frequency

  type :: layers
    real(real_dp) :: number
    real(real_dp), dimension(:), allocatable :: resistivity
    real(real_dp), dimension(:), allocatable :: thickness
  end type layers

  type :: input
    type(transmitter) :: transmitter
    type(receiver) :: receiver
    type(frequency) :: frequency
    type(layers) :: layers
  end type input

end module input_types
