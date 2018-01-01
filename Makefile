all: move rmd2md

move:
		cp inst/vign/pangaear_vignette.md vignettes

rmd2md:
		cd vignettes;\
		mv pangaear_vignette.md pangaear_vignette.Rmd
