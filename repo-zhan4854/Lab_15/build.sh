#!/bin/bash

set -eu

function command_exists() {
	command -v $1 >/dev/null 2>&1
}
function echo_color() {
	echo -e "\x1b[1;3${1}m${2}\x1b[0m"
}
function error() {
	echo_color 1 "${@}" >&2
	exit -1
}
function info() {
	echo_color 6 "${@}"
}
function require() {
	command_exists $1 || error "\`${1}' is required"
}
function warn() {
	echo_color 3 "${@}" >&2
}

info "Building OCaml code..."
if [[ ! -e setup.ml ]]; then
	require oasis
	oasis -quiet setup
fi
require ocaml
if [[ ! -e setup.data ]]; then
	ocaml setup.ml -quiet -configure
fi
if command_exists ocp-indent; then
	ocp-indent -i src/*.ml
else
	warn "\`ocp-indent' isn't installed -- OCaml code will not be deuglied."
fi
ocaml setup.ml -quiet -build

if [[ -x main.byte ]]; then
	COMPILER=./main.byte
elif [[ -x main.native ]]; then
	COMPILER=./main.native
else
	error "Couldn't find the build executable -- it should be main.byte or main.native."
fi;

info "Compiling..."
mkdir -p out
OCAMLRUNPARAM=b ${COMPILER} ${@} > out/main.c
if command_exists astyle; then
	astyle --style=1tbs -nq out/main.c
	# "A2Efk1t8pUxbxC80xexjW3" is an abbreviation for "do what TA Ringo would do."
else
	warn "\`astyle' isn't installed -- C code will be ugly."
fi

info "Building C code..."
require gcc
CFLAGS="${CFLAGS:-} -fcilkplus -I runtime"
gcc -o out/main ${CFLAGS} out/main.c

info "Running C code..."
time ./out/main
