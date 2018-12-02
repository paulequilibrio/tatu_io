module file
  implicit none

contains

  module function file_already_exist(filepath) result(already_exist)
    implicit none
    character(len=*), intent(in) :: filepath
    logical :: already_exist
    inquire(file=filepath, exist=already_exist)
  end function file_already_exist

  module function file_already_open(filepath) result(already_open)
    implicit none
    character(len=*), intent(in) :: filepath
    logical :: already_open
    inquire(file=filepath, opened=already_open)
  end function file_already_open

  module function file_is_readable(filepath) result(is_readable)
    implicit none
    character(len=*), intent(in) :: filepath
    character(len=7) :: readable
    logical :: is_readable
    inquire(file=filepath, read=readable)
    is_readable = merge(.true., .false., readable == 'YES')
  end function file_is_readable

  module function file_is_writable(filepath) result(is_writable)
    implicit none
    character(len=*), intent(in) :: filepath
    character(len=7) :: writable
    logical :: is_writable
    inquire(file=filepath, write=writable)
    is_writable = merge(.true., .false., writable == 'YES')
  end function file_is_writable


  subroutine file_write(fileunit, filepath, content)
    integer, intent(in) :: fileunit
    character(len=*), intent(in) :: filepath, content
    open (unit=fileunit, file=trim(adjustl(filepath)))
    write(fileunit, *) trim(adjustl(content))
    close(fileunit)
  end subroutine file_write
end module file
