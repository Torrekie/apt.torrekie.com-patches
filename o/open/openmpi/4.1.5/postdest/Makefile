all:
# Rename the compiler, startup wrappers and some files.
	for f in mpic++ mpicc mpiCC mpicxx mpiexec mpif77 mpif90 mpirun mpifort; do mv $(dstroot)/usr/bin/$${f} $(dstroot)/usr/bin/$${f}.openmpi; done
	mv $(dstroot)/usr/bin/aggregate_profile.pl $(dstroot)/usr/bin/aggregate_profile
	mv $(dstroot)/usr/bin/profile2mat.pl $(dstroot)/usr/bin/profile2mat
	if test -f $(dstroot)/usr/bin/orte-bootproxy.sh; then \
		mv $(dstroot)/usr/bin/orte-bootproxy.sh $(dstroot)/usr/bin/orte-bootproxy; \
	fi
# Rename the compiler wrapper man pages.
	for f in mpic++ mpicc mpicxx mpiexec mpif77 mpif90 mpirun mpifort ; do \
		if test -f $(dstroot)/usr/share/man/man1/$${f}.1; then \
			echo DEBUG7 $${f} ;\
			mv $(dstroot)/usr/share/man/man1/$${f}.1 $(dstroot)/usr/share/man/man1/$${f}.openmpi.1 ; \
		fi; \
		if test -f $(dstroot)/usr/share/man/man1/$${f}.3; then \
			echo DEBUG8 $${f} ;\
			mv $(dstroot)/usr/share/man/man3/$${f}.3 $(dstroot)/usr/share/man/man1/$${f}.openmpi.3 ; \
		fi; \
	done
	cd $(dstroot)/usr/share/man/man3; \
	for f in *.3; do \
		mv $$f $$(echo $$f|sed -e "s|\.3|.openmpi.3|g"); \
	done;

	for i in mpifh usempi_ignore_tkr usempif08; do \
		$(CC) -dynamiclib -install_name /usr/libexec/openmpi/lib/libmpi_$${i}-gfortran.40.dylib -o $(dstroot)/usr/libexec/openmpi/lib/libmpi_$${i}-gfortran.40.dylib \
			-Wl,-reexport_library,$(dstroot)/usr/libexec/openmpi/lib/libmpi_$${i}.40.dylib && ln -s libmpi_$${i}-gfortran.40.dylib $(dstroot)/usr/libexec/openmpi/lib/libmpi_$${i}-gfortran.dylib; \
	done
# Remove dangling symlink(s)
	rm -f $(dstroot)/usr/share/man/man1/mpiCC.1
	rm -f $(dstroot)/usr/share/man/man1/orteCC.1
# Remove pmi2, pmix now in separate package
	rm -rf $(dstroot)/usr/libexec/openmpi/include/pmi*
# Remove buggy ${pkgincludedir} refs from pkg-config files. #837062
	find . -name '*.pc' -type f | while read f ; do \
		cat $${f} | gsed -e 's%-I$${pkgincludedir}[a-zA-Z0-9/]* %%g' > x ; \
		 mv x $${f}; done
# GFortran / dh_fortran_mod specific
	mkdir -p $(dstroot)/usr/lib/fortran/gfortran-mod-15/openmpi
	cd $(dstroot)/usr/lib/fortran/gfortran-mod-15/openmpi && ln -s ../../../../libexec/openmpi/include/* .
	mv $(dstroot)/usr/libexec/openmpi/lib/*.mod $(dstroot)/usr/lib/fortran/gfortran-mod-15/openmpi/
	chmod 0644 $(dstroot)/usr/lib/fortran/gfortran-mod-15/openmpi/*.mod
	find $(dstroot) -name '*wrapper-data.txt' | while read f; do \
		sed -e 's%$${libdir}/../../fortran%/usr/lib/fortran%g' < $$f | \
		sed -e 's/@COMPILER_VERSION@/gfortran-mod-15/' > tmp.x ; \
		mv tmp.x $$f ; done
# Symlinks
	cd $(dstroot)/usr/lib && ln -s ../libexec/openmpi/lib/*.dylib .
	mkdir -p $(dstroot)/usr/include
	ln -sf ../libexec/openmpi/include $(dstroot)/usr/include/openmpi
	mkdir -p $(dstroot)/usr/lib/pkgconfig
	ln -sf ../../libexec/openmpi/lib/pkgconfig/ompi-cxx.pc $(dstroot)/usr/lib/pkgconfig/ompi-cxx.pc
	ln -sf ../../libexec/openmpi/lib/pkgconfig/orte.pc $(dstroot)/usr/lib/pkgconfig/orte.pc
	ln -sf ../../libexec/openmpi/lib/pkgconfig/ompi-c.pc $(dstroot)/usr/lib/pkgconfig/ompi-c.pc
	ln -sf ../../libexec/openmpi/lib/pkgconfig/ompi-fort.pc $(dstroot)/usr/lib/pkgconfig/ompi-fort.pc
	ln -sf ../../libexec/openmpi/lib/pkgconfig/ompi.pc $(dstroot)/usr/lib/pkgconfig/ompi.pc
	mkdir -p $(dstroot)/usr/lib/fortran/gfortran
	ln -sf ../../libmpi_usempif08-gfortran.40.dylib $(dstroot)/usr/lib/fortran/gfortran/libmpi_usempif08.dylib
	ln -sf ../../libmpi_usempi_ignore_tkr-gfortran.40.dylib $(dstroot)/usr/lib/fortran/gfortran/libmpi_usempi_ignore_tkr.dylib
	ln -sf ../../libmpi_mpifh-gfortran.40.dylib $(dstroot)/usr/lib/fortran/gfortran/libmpi_mpifh.dylib
	ln -sf libmpi_usempi_ignore_tkr-gfortran.40.dylib $(dstroot)/usr/lib/libmpi_usempi_ignore_tkr-gfortran.dylib
	ln -sf opal_wrapper.1 $(dstroot)/usr/share/man/man1/opalCC.1
	ln -sf opal_wrapper.1 $(dstroot)/usr/share/man/man1/opalc++.1
	ln -sf opal_wrapper.1 $(dstroot)/usr/share/man/man1/ortec++.1
	ln -sf mpic++.openmpi.1 $(dstroot)/usr/share/man/man1/mpiCC.openmpi.1
	ln -sf opal_wrapper.1 $(dstroot)/usr/share/man/man1/ortecc.1
	ln -sf opal_wrapper.1 $(dstroot)/usr/share/man/man1/orteCC.1
	ln -sf mpiexec.openmpi.1 $(dstroot)/usr/share/man/man1/mpirun.openmpi.1
	ln -sf mpic++-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpic++.openmpi-wrapper-data.txt
	ln -sf mpicc-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpicc.openmpi-wrapper-data.txt
	ln -sf mpiCC-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpiCC.openmpi-wrapper-data.txt
	ln -sf mpicxx-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpicxx.openmpi-wrapper-data.txt
	ln -sf mpif90-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpif90.openmpi-wrapper-data.txt
	ln -sf mpifort-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpifort.openmpi-wrapper-data.txt
	ln -sf mpif77-wrapper-data.txt $(dstroot)/usr/share/openmpi/mpif77.openmpi-wrapper-data.txt
# dpkg update-alternatives
	rm -f $(dstroot)/usr/lib/libmpi.dylib
