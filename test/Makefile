# Source extension
ext = f08
# Test driver basename
driver = driver
# Test binary executable
executable = driver.bin
# Source path
src = ../source
# Build path
build = ./build
# Fortran Compiler
fc = gfortran
# Fortran Compiler flags
flags = -J$(build) -std=f2008 -pedantic

# json_io modules files
json_io_files = cli file input_types json_io
# Object files relative to each source file in $(json_io_files)
json_io = $(patsubst %, $(build)/%.o, $(json_io_files))

# json-fortran dependencies
json-fortran_files = json_kinds json_parameters json_string_utilities json_value_module json_file_module json_module
# Adds build path and .o extension to each one of json-fortran_files
json-fortran = $(patsubst %, $(build)/%.o, $(json-fortran_files))

# All files matching test_*.$(ext) pattern in test directory
test_src = $(wildcard test_*.$(ext))
# Object files relative to each test file in $(test_src)
test_obj = $(patsubst test_%.$(ext), $(build)/test_%.o, $(test_src))

# If not exist, create build directory
$(shell mkdir -p $(build))


# Run tests
default: $(executable)
	./$(executable) -i ./data/input.json -o ./data/output.json

# Create executable binary
$(executable): $(json-fortran) $(json_io) $(build)/fruit.o $(test_obj) $(build)/$(driver).o
	$(fc) $(flags) -o $(@) $(^)

# Compile json-fortran files
$(build)/%.o: ../json-fortran/%.F90
	$(fc) $(flags) -c $(<) -o $(@)

# Compile json_io files
$(build)/%.o: $(src)/%.$(ext)
	$(fc) $(flags) -c $(<) -o $(@)

# Compile fruit test framework
$(build)/fruit.o: ../fruit/fruit.f90
	$(fc) $(flags) -c $(<) -o $(@)

# Compile test files
$(build)/test_%.o: test_%.$(ext)
	$(fc) $(flags) -c $(<) -o $(@)

# Compile test driver
$(build)/$(driver).o: $(driver).$(ext)
	$(fc) $(flags) -c $(<) -o $(@)

.PHONY: clean cleanall

clean:
	rm -rf $(build)
