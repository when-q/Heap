push!(LOAD_PATH,"../src/")
using Heap

using Documenter

Documenter.makedocs(
	build="build",
	sitename="Heap",
	clean = true,
	doctest = true,
	highlightsig = true,
	expandfirst = [],
	pages = [
			 "Index"=>"index.md",
			 ]
)
