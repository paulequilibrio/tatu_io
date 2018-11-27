build = './build'

$(shell mkdir -p $(build))

$(build)/example.bin: $(build)/json_module.o $(build)/json_kinds.o $(build)/json_parameters.o $(build)/json_value_module.o $(build)/json_string_utilities.o $(build)/json_file_module.o $(build)/example1.o
	gfortran -J$(build) -o $(@) $(^)

# build/example1.o: example1.f08 build/json_module.o build/json_module.o build/json_kinds.o build/json_parameters.o build/json_value_module.o build/json_string_utilities.o build/json_file_module.o
# 	gfortran -Jbuild -c $(<) -o $(@)
#
# build/json_module.o: build/json_kinds.o build/json_parameters.o build/json_value_module.o build/json_file_module.o
# 	gfortran -Jbuild -c json_module.F90 -o $(@)
#
# build/json_kinds.o: json_kinds.F90
# 	gfortran -Jbuild -c $(<) -o $(@)
#
# build/json_parameters.o: json_parameters.F90
# 	gfortran -Jbuild -c $(<) -o $(@)
#
# build/json_value_module.o: json_value_module.F90 build/json_string_utilities.o
# 	gfortran -Jbuild -c $(<) -o $(@)
#
# build/json_string_utilities.o: json_string_utilities.F90
# 	gfortran -Jbuild -c $(<) -o $(@)
#
# build/json_file_module.o: json_file_module.F90
# 	gfortran -Jbuild -c $(<) -o $(@)

$(build)/json_module.o:
	$(MAKE) -C json_io/json-fortran

clean:
	rm -rf ./build
