
   
#!/bin/bash

sudo apt-get update  -qq
#---------------------------------#
# Install System Build Req.
#---------------------------------#
sudo apt-get install -y java-common build-essential software-properties-common zip -qq
sudo apt-get update  -qq
sudo apt install lzip -y -qq
sudo sysctl -w vm.max_map_count=262144

#---------------------------------#
# Install OCaml
#---------------------------------#
sudo apt-get install g++ gcc libctypes-ocaml libparmap-ocaml-dev libc-dev -y
sudo apt-get update
sudo apt update -qq
sudo apt install ocaml-nox -y -qq
sudo apt update -qq

#---------------------------------#
# Install GMP
#---------------------------------#
wget https://gmplib.org/download/gmp/gmp-6.2.0.tar.lz -O /tmp/gmp-6.2.0.tar.lz
lzip -l /tmp/gmp-6.2.0.tar.lz
tar -zvf gmp-6.2.0.tar
cd gmp-6.2.0
./configure
sudo make install
make check


#---------------------------------#
# Install OPAM / DUNE
#---------------------------------#
# /**  OCaml && OPAM && Dune */
sudo add-apt-repository ppa:avsm/ppa
sudo apt update
sudo apt install -y opam m4 -qq --skip-keypress --checkall
sudo apt-get update  -qq


test -r /home/ubuntu/.opam/opam-init/init.sh && . /home/ubuntu/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

sudo apt-get update
#eval $(opam env)
opam update -uy 
#opam switch create ocaml-system.4.11.0
#ocaml-base-compiler 4.11.0
sudo apt-get update  -qq
sudo apt update -qq
opam install async core js_of_ocaml js_of_ocaml-ppx merlin utop ocp-indent -q
sudo apt-get update  -qq
opam user-setup install

opam user-setup install

opam install dune

test -r /home/ubuntu/.opam/opam-init/init.sh && . /home/ubuntu/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# forgot why this is in here
sudo apt-get install libgmp-dev -y -qq

#---------------------------------#
# Install Z3Provier
#---------------------------------#

# /**  Z3Prover  */
git clone https://github.com/Z3Prover/z3 --recursive
cd z3
echo "$PWD"
for remote in `git branch -r`; do git branch --track ${remote#origin/} $remote; done
git fetch --all
#---------------------------------#
# Checkout specific commit to work for EBSO
#---------------------------------#
# git fetch && git checkout 3b1b82bef05a1b5fd69ece79c80a95fb6d72a990
git checkout 3b1b82bef05a1b5fd69ece79c80a95fb6d72a990
git gc

# Use the ``--ml`` command line flag with ``mk_make.py`` to enable building these. this is for OCAML! 
#---------------------------------#
# Build Z3 with OCaml Bindings
# https://github.com/Z3Prover/z3/commit/b301a59899ff401dc1a98dd522b8a8df19471dee
#---------------------------------#
python2.7 scripts/mk_make.py --ml --staticlib
make -C build
