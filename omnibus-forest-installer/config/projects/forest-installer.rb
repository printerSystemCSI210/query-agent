
name "forest-installer"
maintainer "CHANGE ME"
homepage "CHANGEME.com"

replaces        "forest-installer"
install_path    "/opt/forest-installer"
build_version   Omnibus::BuildVersion.new.semver
build_iteration 1

# creates required build directories
dependency "preparation"

# forest-installer dependencies/components
# dependency "somedep"

# version manifest file
dependency "version-manifest"

exclude "\.git*"
exclude "bundler\/git"
