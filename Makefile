all: build

build:
	@dune build

clean:
	@dune clean
	rm -rf _coverage/

coverage:
	@dune runtest -f --instrument-with bisect_ppx
	bisect-ppx-report html
