# Build directory path
build = ../build
src = ./source
# Fortran Compiler
fc = gfortran
# Flags to Fortran Compiler
# -J specifies where to put .mod files for compiled modules
flags = -J$(build) -std=f2008 -pedantic

# Create build directory, if not exists
$(shell mkdir -p $(build))


$(build)/json_io.o: $(src)/json_io.f08 $(build)/json_module.o
	$(fc) $(flags) -c $(<) -o $(@)

$(build)/json_module.o:
	$(MAKE) -C json-fortran

clean:
	rm -rf $(build)
