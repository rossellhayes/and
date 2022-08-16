# and (development version)

* Add support for Windows machines with UTF-8 support and Unix machines without UTF-8 support.
  - Previously, `and` treated all Windows machines as non-UTF-8 and all Unix machines as UTF-8.

# and 0.1.1

* `set_language()` can now unset the `LANGUAGE` environment variable if its input is an empty string (`""`) or has length 0 (e.g. `NULL`).

# and 0.1.0

* Initial release.
