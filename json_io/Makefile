src = ./source
build = ./build

$(shell mkdir -p $(build))

$(build)/json_io.o: $(src)/json_io.f08 $(build)/json_module.o
	gfortran -J$(build) -c $(<) -o $(@)

$(build)/json_module.o:
	$(MAKE) -C json-fortran

clean:
	rm -rf ./build
