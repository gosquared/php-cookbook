maintainer        "Gerhard Lazu"
maintainer_email  "gerhard@lazu.co.uk"
license           "Apache 2.0"
description       "Installs and maintains php and php modules"
version           "2.0.0"

depends "build-essential"
depends "xml"
depends "mysql"

supports "debian"
supports "ubuntu"
supports "centos"
supports "redhat"
supports "fedora"

recipe "php", "Installs php"
recipe "php::package", "Installs php using packages."
recipe "php::source", "Installs php from source."
# And many, many more PHP modules
# These should be configurable. Just pass them to the providers and they will
# deal with them
