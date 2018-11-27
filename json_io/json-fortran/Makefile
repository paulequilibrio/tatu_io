src = ./source
build = ./build
lib = ./lib
flags = -fbacktrace -fno-omit-frame-pointer -O3 -DNDEBUG -O3

$(shell mkdir -p $(build) $(lib))

$(build)/json_module.o: $(src)/json_module.F90 $(build)/json_kinds.o $(build)/json_parameters.o $(build)/json_value_module.o $(build)/json_file_module.o
	gfortran $(flags) -J$(build) -c $(<) -o $(@)

$(lib)/libjsonfortran.a: $(build)/json_kinds.o $(build)/json_parameters.o $(build)/json_string_utilities.o $(build)/json_value_module.o $(build)/json_file_module.o $(build)/json_module.o
	ar qc $(@) $(^)
	ranlib $(@)

$(build)/json_kinds.o: $(src)/json_kinds.F90
	gfortran $(flags) -J$(build) -c $(<) -o $(@)

$(build)/json_parameters.o: $(src)/json_parameters.F90
	gfortran $(flags) -J$(build) -c $(<) -o $(@)

$(build)/json_value_module.o: $(src)/json_value_module.F90 $(build)/json_string_utilities.o
	gfortran $(flags) -J$(build) -c $(<) -o $(@)

$(build)/json_string_utilities.o: $(src)/json_string_utilities.F90
	gfortran $(flags) -J$(build) -c $(<) -o $(@)

$(build)/json_file_module.o: $(src)/json_file_module.F90
	gfortran $(flags) -J$(build) -c $(<) -o $(@)

clean:
	rm -rf $(build) $(lib)


# build/example1.bin: build/json_module.o build/json_kinds.o build/json_parameters.o build/json_value_module.o build/json_string_utilities.o build/json_file_module.o build/example1.o
# 	gfortran -Jbuild -o $(@) $(^)

# build/example1.o: example1.f08 build/json_module.o build/json_module.o build/json_kinds.o build/json_parameters.o build/json_value_module.o build/json_string_utilities.o build/json_file_module.o
# 	gfortran -Jbuild -c $(<) -o $(@)
