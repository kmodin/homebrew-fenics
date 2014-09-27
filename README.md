# Build FEniCS from Scratch

A simple script to build [FEniCS](http://fenicsproject.org) version 1.4.0 on Mac OS X 10.9 (Mavericks) relying on [Homebrew](http://brew.sh) and [pip](http://www.pip-installer.org).


1. Install [Homebrew](http://brew.sh):
  
  ```
  ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  ```
2. Add the science, python, and versions taps
  
  ```
  brew tap homebrew/science
  brew tap homebrew/python
  brew tap homebrew/versions
  ```

3. Add this tap:
  
  ```
  brew tap kmodin/homebrew-fenics
  ```

3. Install the python from brew:
  
  ```
  brew install python
  brew linkapps
  ```

4. Install Python packages `numpy`, `matplotlib`, `scipy` and `ply`:

  ```
  cd /usr/local/Library/Taps/homebrew/homebrew-python
  git checkout 8a98fa1 numpy.rb
  cd -
  brew install numpy
  brew install scipy
  pip install ply
  ```

5. Install `dolfin` with `vtk` and MPI support:

  ```
  brew install dolfin --env=std
  ```

6. Alternatively, install without MPI support:

  ```
  brew install dolfin --without-mpi --env=std
  ```

7. Or without `vtk` support:

  ```
  brew install dolfin --without-vtk
  ```



## Some comments on `dolfin.rb.`

#### Included packages

With everything included (nothing excluded with `--without`) the following should be produced (use the `-v` option to verify):
```no-highlight
-- The following optional packages were found:
-- -------------------------------------------
-- (OK) MPI
-- (OK) PETSC
-- (OK) SLEPC
-- (OK) UMFPACK
-- (OK) CHOLMOD
-- (OK) PASTIX
-- (OK) SCOTCH
-- (OK) PARMETIS
-- (OK) CGAL
-- (OK) ZLIB
-- (OK) PYTHON
-- (OK) HDF5
-- (OK) VTK
-- (OK) QT
-- (OK) PETSC4PY
-- 
-- The following optional packages were not found:
-- -----------------------------------------------
-- (**) OPENMP
-- (**) TAO
-- (**) TRILINOS
-- (**) SPHINX
```
#### Demos

Demos are included here:
```
/usr/local/Cellar/dolfin/1.4.0/share/dolfin/demo
```

#### Issues

There are several outstanding issues:

- `numpy` version 1.8 is necessary since [ScientificPython](https://sourcesup.renater.fr/frs/?group_id=180&release_id=2480#development-releases-_2.9.3-title-content) requires the `numpy.oldnumeric` module, removed in version 1.9 of `numpy`.

- Relying on `depends_on slepc` to install `slepc` has path issues.

- MPI works with `open-mpi`.  There are issues, possibly with Boost, with `mpich2`.

- Currently `tao` does not work.  There is an issue with the installation of the `lib`.

- With `sphinx` installed, `dolfin` cannot find it.

- Currently, `trilinos` does not work.

## To create a virtual environment

1. Install virtualenv and virtualenvwrapper if you haven't already
    ```
    pip install virtualenv
    pip install virtualenvwrapper
    ```
2. Configure virtualenvwrapper (see the [documentation](http://virtualenvwrapper.readthedocs.org/en/latest/)).
    Create the directory:
    ```
    mkdir -p $HOME/.virtualenvs
    ```
    Then add the foolowing to your shell rc-file:
    ```
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
    ```
    Now create a virtualenv and activate
    ```
    mkvirtualenv fenics
    workon fenics
    ```

