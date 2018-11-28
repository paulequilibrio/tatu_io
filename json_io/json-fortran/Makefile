# Build directory path
build = ../../build
# Fortran Compiler
fc = gfortran
# Flags to Fortran Compiler
flags = -J$(build) -fbacktrace -fno-omit-frame-pointer -O3 -DNDEBUG -O3
# Create build directory, if not exists
$(shell mkdir -p $(build))

$(build)/json_module.o: json_module.F90 $(build)/json_kinds.o $(build)/json_parameters.o $(build)/json_string_utilities.o $(build)/json_value_module.o $(build)/json_file_module.o
	$(fc) $(flags) -c $(<) -o $(@)

$(build)/%.o: %.F90
	$(fc) $(flags) -c $(<) -o $(@)

clean:
	rm -rf $(build)
