# Build directory path
build = ../../build
# Fortran Compiler
fc = gfortran
# Fortran Compiler flags
flags = -J$(build) -fbacktrace -fno-omit-frame-pointer -O3 -DNDEBUG -O3
# If not exist, create build directory
$(shell mkdir -p $(build))

# Build the main module object
$(build)/json_module.o: json_module.F90 $(build)/json_kinds.o $(build)/json_parameters.o $(build)/json_string_utilities.o $(build)/json_value_module.o $(build)/json_file_module.o
	$(fc) $(flags) -c $(<) -o $(@)

# Build dependencies objects
$(build)/%.o: %.F90
	$(fc) $(flags) -c $(<) -o $(@)

clean:
	rm -rf $(build)
