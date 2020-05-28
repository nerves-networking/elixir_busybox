# Changelog

## v0.1.5

* Bug fixes
  * Pull upstream patch to remove stime calls that now fail to build with new
    glibc versions.

## v0.1.4

* Updates
  * Bump Busybox to 1.31.1. This is the latest stable release.

* Bug fixes
  * Remove parallel build. This causes issues on Macs and it's not clear why. It
    seems simpler to remove it for now.

## v0.1.3

* Bug fixes
  * Fix issue causing Busybox patches to be re-applied on rebuilds
  * Add error messages when packages are missing on OSX

## v0.1.2

* Improvements
  * Support sending out the DNS server's IP address with udhcpd

* Bug fixes
  * Minor tweaks to scripts to make them work on different platforms better
  * Improvements to stubs generated on OSX to make some trivial unit testing
    possible in applications that use this

## v0.1.1

* Bug fixes
  * Add run-parts which seems to be called from other utilities

## v0.1.0

Initial release to hex.
