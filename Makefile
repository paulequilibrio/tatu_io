# Build directory path
build = ../build
# Fortran Compiler
fc = gfortran
# Fortran Compiler flags
# -J specifies where to put .mod files for compiled modules
flags = -J$(build) -std=f2008 -pedantic

# json_io modules files
json_io_files = cli file input_types output json_io
# Object files relative to each source file in $(json_io_files)
json_io = $(patsubst %, $(build)/%.o, $(json_io_files))

# If not exist, create build directory
$(shell mkdir -p $(build))


default: jsonfortran $(json_io)

# Runs the first target of Makefile in ./json-fortran directory
jsonfortran:
	$(MAKE) -C json-fortran

# Compile json_io files
$(build)/%.o: source/%.f08
	$(fc) $(flags) -c $(<) -o $(@)

clean:
	rm -rf $(build)
