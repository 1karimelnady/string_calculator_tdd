# String Calculator - TDD Kata

This repository contains a Dart implementation of the String Calculator kata with TDD tests.

## How to run tests
1. `dart pub get`
2. `dart test`

## Features
- Empty string -> 0
- Comma and newline separators
- Custom delimiters using `//[delimiter]\n`
- Multi-char and multiple delimiters (e.g. `//[***][%]\n`)
- Throws `NegativeNumbersException` listing all negative numbers