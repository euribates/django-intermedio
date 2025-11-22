SPHINXBUILD := "sphinx-build"
SOURCEDIR := "./source"
BUILDDIR  := "./build"

# first option, so "just" without argument is like "just help".
help *args='':
	{{SPHINXBUILD}} -M help {{ SOURCEDIR }} {{ BUILDDIR}} {{ args }}

# Genera la documentación en HTML
docs *args='': 
	{{SPHINXBUILD}} -M html {{ SOURCEDIR }} {{ BUILDDIR}} {{ args }}


# Genera la documentación en HTML
clean: 
	{{SPHINXBUILD}} -M clean {{ SOURCEDIR }} {{ BUILDDIR}}
