require 'formula'

class Dolfin < Formula
  homepage 'https://bitbucket.org/fenics-project/dolfin'
  url 'https://bitbucket.org/fenics-project/dolfin/downloads/dolfin-1.4.0.tar.gz'
  sha1 'b58cb5e4aaef0825ded1237ba6012d7aee63c152'

  depends_on :fortran
  depends_on :python

  # Check Python dependencies
  depends_on 'numpy' => :python
  depends_on 'ply' => :python
  depends_on 'matplotlib' => :python

  # Check build dependencies
  depends_on 'cmake' => :build
  depends_on 'cppunit' => :build
  depends_on 'pkg-config' => :build
  depends_on 'swig' => :build

  # Check non-mpi dolfin dependencies
  depends_on 'suite-sparse'
  depends_on 'eigen'
  depends_on 'cgal43' => :recommended

  option 'without-mpi', 'Build without mpi support'
  if build.without? 'mpi'
    depends_on 'boost' => ['without-single']
  end

  # Check mpi dolfin dependencies
  unless build.without? 'mpi'
    depends_on :mpi => [:cc, :cxx, :f90, :recommended]
    #depends_on 'slepc' => :recommended if build.with? :mpi
    depends_on 'scotch' => :recommended
    depends_on 'pastix' => :recommended
    depends_on 'parmetis' => ['shared', :recommended]
    depends_on 'hdf5' => ['enable-parallel', :recommended]
    depends_on 'scalapack' => ['with-openblas', 'without-check', 'with-shared-libs']
    depends_on 'mumps' => ['with-openblas']
    depends_on 'petsc-fenics' => ['with-hypre', 'with-metis', 'with-parmetis', 'with-mumps', 'with-scalapack', 'with-suite-sparse', :recommended]
    depends_on 'boost' => ['without-single', 'with-mpi']
  end

  # Check VTK dolfin dependencies
  option 'without-vtk', 'Build without vtk support'
  unless build.without? 'vtk'
    depends_on 'sip'
    depends_on 'pyqt'
    depends_on 'vtk' => ['with-matplotlib', 'with-qt']
  end

  # Check fenics dependencies
  depends_on 'fiat'
  depends_on 'ufl'
  depends_on 'ffc'
  depends_on 'instant'

  def install
    if ENV.compiler == :clang
      opoo 'OpenMP support will not be enabled. Use --use-gcc if you require OpenMP.'
    end

    ENV.deparallelize
    ENV['PETSC_DIR'] = Formula['petsc-fenics'].prefix
    ENV['PETSC_ARCH'] = 'arch-darwin-c-opt'
    #ENV['SLEPC_DIR'] = Formula.factory('slepc').prefix
    ENV['TAO_DIR'] = Formula['tao'].prefix
    ENV['PARMETIS_DIR'] = Formula['parmetis'].prefix
    ENV['AMD_DIR'] = Formula['suite-sparse'].prefix
    ENV['CHOLMOD_DIR'] = Formula['suite-sparse'].prefix
    ENV['UMFPACK_DIR'] = Formula['suite-sparse'].prefix

    # ENV['SCOTCH_DIR'] = Formula.factory('scotch').prefix
    # ENV['PASTIX_DIR'] = Formula.factory('pastix').prefix
    # ENV['CPPUNIT_DIR'] = Formula.factory('cppunit').prefix
    # ENV['CGAL_DIR'] = Formula.factory('cgal').prefix
    # This is necessary to discover CGAL.
    #ENV.append_to_cflags '-frounding-math'

    mkdir 'build' do
      system 'cmake', '..', *std_cmake_args
      system 'make'
      system 'make', 'install'
    end
  end
end
