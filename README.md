# 42 C++98 Project Template

Welcome to your automated C++98 development environment, tailored specifically for the 42 School curriculum!

### What this repository does
This is a ready-to-use C++98 project template that comes pre-configured with a powerful `Makefile`. It automatically handles compilation, formatting, linting, memory checking, and even unit testing. It comes with a sample boilerplate (the classic `Harl` exercise) so you can see it in action immediately.

### Why is this repository useful
Let's be honest, setting up a C++98 environment that strictly adheres to the 42 Norm (v4) and catches every single memory leak is tedious. This template saves you hours of setup and debugging by providing:
- **Strict C++98 Compilation:** Built-in enforcement of `c++98` alongside exhaustive compiler flags (`-Wall`, `-Wextra`, `-Werror`, `-Wshadow`, `-Wpedantic`, etc.). If your code compiles here, it will compile during evaluation.
- **Built-in Testing & Valgrind:** Integrated `doctest` for simple, inline unit testing. Automated `valgrind` hooks catch memory leaks instantly—no more finding out you have a leak the night before the deadline.
- **Automated Linting & Formatting:** The `Makefile` dynamically generates `.clang-format`, `.clang-tidy`, and `.clangd` configurations on the fly. This keeps your codebase perfectly styled without dirtying your git tree.
- **Print statement driven development:** Harl will print all four logs, but only whem compile with the `DEBUG` flag. Comes with four logging levels. Keep your main executable pristine.
- **Auto-magic Banners:** Need to update your headers? Just run `make headers` and it's done. Check the Makefile and make your own personalized header!

---

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/d-branco/cpp98-template.git PROJECT_NAME/
   cd PROJECT_NAME
   ```
2. **See it in action:** Run the following command to compile the boilerplate `Harl` code, run its tests, and automatically check for memory leaks using `valgrind`.
   ```bash
   make test
   ```
3. **Make it yours:** Edit the Makefile to have your desire logging level `DEBUG_LEVEL`, add a name for the executable `NAME`, change the headers to your personal ones, add `ARGS` for running with predefined arguments, etc. Then start writing your own C++98 code in the `srcs/` and `include/` directories!

4. **Code with clarity:** Use Harl to print messages that only appear when compiling a debuggin executable with `make debug`. They won't appear on the main executable and are useful to code slowly and clearly. Fours levels of logging by default.

5. **Run in four modes:**

| Command         | Description                                                       |
| :-------------- | :---------------------------------------------------------------- |
| `make run`      | Compiles the main executable if needed, and executes it           |
| `make debug`    | Compiles with debug  prints and symbols (`-g3`, `-O0`) for `gdb`. |
| `make docstest` | Compiles 'doctest' unit tests and runs them.                      |
| `make valgrind` | Runs through `valgrind` to detect memory leaks.                   |

Or just run `make test` and do all in a command.

---

## Daily Workflow

Here is how you actually use the tools provided in your day-to-day coding:

1. **Write Code:** Put your `.cpp` files in `srcs/` and your `.hpp` files in `include/`.
2. **Format Code:** Run `make format` to automatically fix your code style (indentation, braces, etc.) before you commit.
3. **Run with loggs** Run `make debug` to see the code running with print statements.
4. **Test Code:** Run `make test` frequently to run your `doctest` unit tests and instantly catch memory leaks with `valgrind`.
5. **Update Banners:** Run `make headers` to automatically create or update the 42 file banners across all your source and header files.

---

## Prerequisites & Structure

### Required Dependencies
Make sure you have these installed on your system:
- `make`
- A C++ compiler (`clang++` or `g++`)
- `clang-format` and `clang-tidy` (for style enforcement)
- `valgrind` (for memory leak detection)

### Directory Structure
- `srcs/`: Your source code (`.cpp` files).
- `include/`: Your header files (`.hpp` files).
- `Makefile`: The brains of the operation.

---

## Build Commands

Here is a breakdown of what the `Makefile` can do for you.

### Compilation
| Command         | Description                                                       |
| :-------------- | :---------------------------------------------------------------- |
| `make`          | Compiles the main executable (`a.out`).                           |
| `make clean`    | Removes object files (`.o` files).                                |
| `make fclean`   | Removes object files and all executables.                         |
| `make re`       | Performs `fclean` followed by `make`.                             |
| `make debug`    | Compiles the project with debug symbols (`-g3`, `-O0`) for `gdb`. |

### Execution
| Command         | Description                                                       |
| :-------------- | :---------------------------------------------------------------- |
| `make run`      | Compiles the main executable if needed, and executes it           |
| `make exe`      | Performs 'fclean', recompiles and runs the executable             |

### Testing & Debugging
| Command         | Description                                                       |
| :-------------- | :---------------------------------------------------------------- |
| `make test`     | Compiles tests (`doctest`), runs them, and runs `valgrind`.       |
| `make docstest` | Compiles 'doctest' tests amd runs them.                           |
| `make valgrind` | Runs through `valgrind` to detect memory leaks.                   |

### Formatting & Style
| Command         | Description                                                       |
| :-------------- | :---------------------------------------------------------------- |
| `make format`   | Formats all source files according to `.clang-format`.            |
| `make style`    | Checks the codebase against `.clang-tidy` without making changes. |
| `make fix-style`| Attempts to auto-fix styling issues using `clang-tidy --fix`.     |
| `make headers`  | Updates the 42 file banners across all `.cpp` and `.hpp` files.   |

---

## 42 Submission Guidelines

> **STOP! Read this before you push to the 42 intra!**

This template is an incredible tool for *local development*, but it is **NOT ready for direct 42 intra submission**. You **must** make the following modifications before your final push, or you risk failing your evaluation:

1. **Remove External Dependencies:** 42 C++ projects typically forbid external libraries. You must **remove `doctest.h`** from the `include/external/` directory and strip out any tests that rely on it (e.g., `#ifdef TESTING` blocks).
2. **Explicit Source Files in `Makefile`:** The current `Makefile` uses `find` (or `wildcard`) to auto-discover your source and header files. 42 evaluation strictly requires that all `.cpp` and `.hpp` files in the `SRCS` and `HEADERS` variables are **explicitly named**. Update the `Makefile` manually.
3. **Check Forbidden Functions:** No unauthorized external functions. Double-check the subject and use tools like `nm` to verify your executable's symbols.
4. **`Makefile` Rules:** Ensure your final `Makefile` contains all strictly required rules (`all`, `clean`, `fclean`, `re`) and outputs the correct **executable name** defined in the subject.

---

## Coding Style & Guidelines

See [**`STYLE.md`**](STYLE.md) for naming conventions, forbidden keywords, and strict C++98 guidelines for this template.

---

## Dependencies & Attribution
- This project uses `doctest.h` version 1.2.9 (included in the `include/external/` directory) for C++98 compatibility.

```txt
Copyright (c) 2016-2018 Viktor Kirilov
Licensed under the MIT License
https://github.com/onqtam/doctest
```
