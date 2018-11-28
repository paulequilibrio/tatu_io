# Build directory path
build = ./build
# Fortran Compiler
fc = gfortran
# Flags to Fortran Compiler
# -J specifies where to put .mod files for compiled modules
flags = -J$(build) -std=f2008 -pedantic

# Create build directory, if not exists
$(shell mkdir -p $(build))

# json_io dependencies
json_io_files = json_io json_module json_kinds json_parameters json_value_module json_string_utilities json_file_module
# Adds build path and .o extension to each one of json_io_files
json_io = $(patsubst %, $(build)/%.o, $(json_io_files))


# Target to create executable binary
example.bin: $(json_io) $(build)/example.o
# $(@) represents the current target, in this case: $(@) = example.bin
# $(^) represents all dependencies of the current target, in this case: all .o files
	$(fc) $(flags) -o $(@) $(^)

# Compile the main program
$(build)/example.o: example.f08
# $(<) represents the first dependency of the current target, in this case: $(<) = example.f08
	$(fc) $(flags) -c $(<) -o $(@)

# Runs the first target of Makefile in ./json_io directory
$(build)/json_io.o:
	$(MAKE) -C json_io

clean:
	rm -rf $(build)
