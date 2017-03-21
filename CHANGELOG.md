# Changelog

* 0.4.0
 * Removed swift 2 support

* 0.3.0
 * Updated to support building with Xcode 8/Swift 3 (still supports Xcode 7.3/Swift 2.2 for now as well)

* 0.2.3
 * Removed redundant weakify function
 * Removed duplicate targets, library builds with one universal target now.
 * Upgraded project to support building in Xcode 8/Swift 2.3

* 0.2.2
 * Added support for building Weakify with the swift package manager.

* 0.2.1
 * tvOS framework added
 * watchOS framework fixed (did not properly contain weakify.swift)

* 0.2.0
 * Swift 2.0 support:
  * Alternative throwing versions of all existing weakify methods
  * Second argument to all methods is now hidden
 * watchOS variant of the framework

* 0.1.3 - Proper ios/osx framework targets

* 0.1.0 - Initial release
