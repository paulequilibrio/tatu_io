module input_types
  integer, parameter :: input_dp = kind(1.d0)

  type :: point
    real(input_dp) :: x
    real(input_dp) :: y
    real(input_dp) :: z
  end type point

  type :: source
    character(5) :: model
    character(1) :: direction
    type(point) initial
    real(input_dp) :: step
    real(input_dp) :: final
  end type source

  type :: receiver
  end type receiver

  type :: frequency
  end type frequency

  type :: layers
  end type layers

  type :: input
    type(source) :: source
    type(receiver) :: receiver
    type(frequency) :: frequency
    type(layers) :: layers
  end type input

end module input_types
