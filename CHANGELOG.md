# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

### Added

- Make OAuth scopes configurable

### Changed

- Bump/relax version guard for the HTTP gem

### Removed

- Remove EOL Rubies up to 3.2

### Fixed

- Handle OAuth grant errors properly

## [0.4.1] - 2021-09-07

### Fixed

- Remove call to missing method

## [0.4.0] - 2021-05-27

### Changed

- Relax version requirement on the HTTP gem

## [0.3.5] - 2021-03-18

### Added

- Add market id to various apis

## [0.3.4] - 2021-02-22

### Added

- Add shorthands to instantiate requests

### Fixed

- Fix #get_multiple_items and #get_item_status in Shopping

[Unreleased]: https://github.com/hakanensari/ebay-ruby/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/hakanensari/peddler/compare/v0.3.5...v0.4.0
[0.3.5]: https://github.com/hakanensari/peddler/compare/v0.3.4...v0.3.5
[0.3.4]: https://github.com/hakanensari/peddler/compare/v0.3.3...v0.3.4
