# Silent make output
MAKEFLAGS += --silent
# Build directory path
build = ./build
# Fortran Compiler
fc = gfortran
# Flags to Fortran Compiler
# -J specifies where to put .mod files for compiled modules
flags = -J$(build) -std=f2008 -pedantic

# If not exist, create build directory
$(shell mkdir -p $(build))

# json_io dependencies
json-fortran = json_module json_kinds json_parameters json_value_module json_string_utilities json_file_module
json_io = cli file input_types json_io $(json-fortran)
# Adds build path and .o extension to each one of json_io_files
json_io_obj = $(patsubst %, $(build)/%.o, $(json_io))


# Target to create executable binary
example.bin: $(json_io_obj) $(build)/example.o
# $(@) represents the current target, in this case: $(@) = example.bin
# $(^) represents all dependencies of the current target, in this case: all .o files
	$(fc) $(flags) -o $(@) $(^)

# Runs the first target of Makefile in ./json_io directory
$(build)/%.o: json_io/source/%.f08
	$(MAKE) -C json_io

# Compile the main program
$(build)/example.o: example.f08
# $(<) represents the first dependency of the current target, in this case: $(<) = example.f08
	$(fc) $(flags) -c $(<) -o $(@)

clean:
	rm -rf $(build)
