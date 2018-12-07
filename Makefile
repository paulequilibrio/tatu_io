# Build directory path
build = ../build
# Fortran Compiler
fc = gfortran
# Fortran Compiler flags
# -J specifies where to put .mod files for compiled modules
flags = -J$(build) -std=f2008 -pedantic

# If not exist, create build directory
$(shell mkdir -p $(build))

# json-fortran variable from file
include json-fortran/dependencies.make
# json_io variable from file
include ./dependencies.make
# Object files relative to each source file in $(json_io)
json_io.o = $(patsubst %, $(build)/%.o, $(json_io))


default: jsonfortran $(json_io.o)

# Runs the first target of Makefile in ./json-fortran directory
jsonfortran:
	$(MAKE) -C json-fortran

# Compile json_io files
$(build)/%.o: source/%.f08
	$(fc) $(flags) -c $(<) -o $(@)

clean:
	rm -rf $(build)
