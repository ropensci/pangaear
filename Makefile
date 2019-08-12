RSCRIPT = Rscript --no-init-file

all: move rmd2md

move:
		cp inst/vign/pangaear_vignette.md vignettes

rmd2md:
		cd vignettes;\
		mv pangaear_vignette.md pangaear_vignette.Rmd

install: doc build
	R CMD INSTALL . && rm *.tar.gz

build:
	R CMD build .

doc:
	${RSCRIPT} -e "devtools::document()"

eg:
	${RSCRIPT} -e "devtools::run_examples()"

check:
	${RSCRIPT} -e "devtools::check(document = FALSE, cran = TRUE)"

test:
	${RSCRIPT} -e "devtools::test()"

pkgdocs:
	${RSCRIPT} -e "pkgdown::build_site()"
