program fruit_driver
  use fruit
  use test_cli
  use test_file
  call init_fruit(1)

  call test_cli_get_argument
  call test_cli_get_option_value

  call test_file_already_exist
  call test_file_already_open
  call test_file_is_readable
  call test_file_is_writable

  call fruit_summary
  call fruit_finalize
end program fruit_driver
