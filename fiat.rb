require 'formula'

class Fiat < Formula
  homepage 'https://bitbucket.org/fenics-project/fiat'
  url 'https://bitbucket.org/fenics-project/fiat/downloads/fiat-1.4.0.tar.gz'
  sha1 'ea77559760ec862353c5d2a9d31d471294471a9f'

  depends_on :python
  depends_on 'numpy' => :python

  resource('scientificpython') do
    url 'https://sourcesup.renater.fr/frs/download.php/4425/ScientificPython-2.9.3.tar.gz'
    sha1 'e3115b1f6c76d33fd7a4e300ccd6332d145889fd'
  end

  def install
    ENV.deparallelize

    resourceargs = ['setup.py', 'install', "--prefix=#{prefix}"]
    resource('scientificpython').stage {system 'python', *resourceargs }

    system 'python', 'setup.py', 'install', "--prefix=#{prefix}"
  end
end
