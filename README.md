# C++98 Project Template

C++98 project template tailored to the 42 School curriculum. Provides an automated development environment with built-in formatting, linting, memory checking, and unit testing via the `Makefile`.

## Features

- **Strict C++98 Compilation**: Built-in enforcement of `c++98` alongside exhaustive compiler flags (`-Wall`, `-Wextra`, `-Werror`, `-Wshadow`, `-Wpedantic`, etc.).
- **Built-in Testing & Valgrind**: Integrated `doctest` for simple, inline unit testing and automated `valgrind` hooks to catch memory leaks instantly.
- **Automated Linting & Formatting**: Dynamically generates `.clang-format`, `.clang-tidy`, and `.clangd` configurations directly from the Makefile to maintain consistent styling without dirtying the git tree unnecessarily.
- **Personal Header Generation**: Target `make headers` to automatically create or update file banners.

## Getting Started

### Prerequisites

Required dependencies:
- `make`
- A C++ compiler (`clang++` or `g++`)
- `clang-format` and `clang-tidy` (for style enforcement)
- `valgrind` (for memory leak detection)

### Directory Structure

- `srcs/`: Source code (`.cpp` files).
- `include/`: Header files (`.hpp` files).
- `Makefile`: Main build script.

## Build Commands

| Command         | Description                                                       |
| :-------------- | :---------------------------------------------------------------- |
| `make`          | Compiles the main executable.                                     |
| `make clean`    | Removes object files.                                             |
| `make fclean`   | Removes object files and all executables.                         |
| `make re`       | Performs `fclean` followed by `make`.                             |
| `make test`     | Compiles tests (`doctest`), runs them, followed by `valgrind`     |
| `make debug`    | Compiles the project with debug symbols (`-g3`, `-O0`).           |
| `make valgrind` | Runs the executable through `valgrind` to detect memory leaks.    |
| `make format`   | Formats all source files according to `.clang-format`             |
| `make style`    | Checks the codebase against `.clang-tidy` without making changes. |
| `make fix-style`| Attempts to auto-fix styling issues using `clang-tidy --fix`.     |
| `make headers`  | Updates file banners across all `.cpp` and `.hpp` files.          |

## 42 Submission Guidelines

This template is for local development only and **is not ready for direct 42 intra submission**. The following modifications are required for project compliance:

1. **Removal of External Dependencies:** 42 C++ projects typically forbid external libraries. Remove `doctest.h` from the `include/` directory and strip out any tests that rely on it.
2. **Explicit Source Files in `Makefile`:** The current `Makefile` uses `find` (or `wildcard`) to auto-discover source and header files. 42 evaluation strictly requires that all the `.cpp` and `.hpp` files in the `SRCS` and `HEADERS` variables are explicitly named.
3. **Forbidden Functions:** No unauthorized external functions. Double-check the subject and use tools like `nm` to verify executable symbols.
4. **`Makefile` Rules:** The `Makefile` must contain all strictly required rules (`all`, `clean`, `fclean`, `re`) and output the correct executable name.

## Coding Style & Guidelines

**See [`STYLE.md`](STYLE.md) for naming conventions, forbidden keywords, and C++98 guidelines.**

## Dependencies
- doctest.h v1.2.9 (included in `include/` directory)

## Attribution
This project uses doctest.h version 1.2.9 (for C++98 compatibility)
```txt
Copyright (c) 2016-2018 Viktor Kirilov
Licensed under the MIT License
https://github.com/onqtam/doctest
```