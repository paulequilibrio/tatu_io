module input_types
  integer, parameter :: sp = kind(1.e0)
  integer, parameter :: dp = kind(1.d0)

  type :: point
    real(dp) :: x
    real(dp) :: y
    real(dp) :: z
  end type point

  type :: source
    character(5) :: model
    character(1) :: direction
    type(point) initial
    real(dp) :: step
    real(dp) :: final
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
