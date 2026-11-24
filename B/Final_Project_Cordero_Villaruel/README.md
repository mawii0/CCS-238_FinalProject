# CCS 238 Final Project — FORTRAN (1957) vs. Rust (2015)

## Main argument

Rust provides stronger compile-time enforcement of ordinary safe-reference access through ownership and borrowing. Modern Fortran has particularly concise numerical-array syntax and an established scientific-computing ecosystem. The study compares design priorities, safety contracts, and trade-offs, with baseline execution-time measurements for the three program pairs.

## The six companion programs

| Pair | Fortran | Rust | Topics | Expected output |
|---|---|---|---|---|
| 01 — Vector Statistics | [`Fortran/01_vector_stats.f90`](Fortran/01_vector_stats.f90) | [`Rust/01_vector_stats.rs`](Rust/01_vector_stats.rs) | Arrays, `INTENT(IN)`, borrowed slices, `Option` | Count 5; mean 5.00; max 9 |
| 02 — Account Update | [`Fortran/02_account_update.f90`](Fortran/02_account_update.f90) | [`Rust/02_account_update.rs`](Rust/02_account_update.rs) | Derived types/structs, `INTENT(INOUT)`, `&mut`, checked arithmetic | Balance 125; positive accepted; negative rejected |
| 03 — Parse Totals | [`Fortran/03_parse_totals.f90`](Fortran/03_parse_totals.f90) | [`Rust/03_parse_totals.rs`](Rust/03_parse_totals.rs) | Control flow and recoverable errors; `IOSTAT` versus `Result` | Four accepted; one rejected; total 41 |

Each implementation uses the same sample input and produces matching output. The construct notes below explain the language-specific syntax.

## Compiler versions and verification status

All six programs were compiled and executed successfully in Visual Studio Code on Windows, with matching outputs for each pair.

| Tool | Version |
|---|---|
| GNU Fortran (`gfortran`) | 16.2.0 (Rev4, Built by MSYS2 project) |
| Rust (`rustc`) | 1.100.0 (0ef1bc386 2026-11-09) |

**Historical distinction:** FORTRAN (1957) and Rust (2015) identify the original releases. The companion programs use modern Fortran features and can be built with the Fortran 2018 standard option and Rust 2021 edition option. The historical compilers were not used.

## How to run each program in Visual Studio Code (Windows PowerShell)

### Step 1 — Prepare the environment

1. Open the `Final_Project_Cordero_Villaruel` folder in Visual Studio Code (File > Open Folder).
2. Open Terminal > New Terminal and select PowerShell.
3. Make sure the terminal is in the folder containing this README. If you opened the class repository root, run `cd "B\Final_Project_Cordero_Villaruel"` first.
4. Verify that GNU Fortran and Rust are installed and accessible. Create local build folders using the following commands:

```powershell
gfortran --version
rustc --version
Get-ChildItem Fortran, Rust
New-Item -ItemType Directory -Force output/bin, output/build | Out-Null
```

The build folders are generated locally and are not part of the GitHub submission. If `rustc` reports a missing MSVC linker, install the Visual C++ build tools and Windows SDK or use a configured Developer PowerShell.

### Step 2 — Compile and execute the programs

Run the commands for whichever implementation you want to test. Each compile command creates an executable; the next command runs it only if compilation succeeds. All programs have fixed sample inputs, so no keyboard input or external data file is required.

#### Program 01 — Vector Statistics

Calculates the count, mean, and maximum of the fixed array `[4, 7, 2, 9, 3]`.

**Fortran:**

```powershell
gfortran -std=f2018 -Wall -Wextra -fcheck=all -J output/build Fortran/01_vector_stats.f90 -o output/bin/f01.exe
if ($LASTEXITCODE -eq 0) { .\output\bin\f01.exe }
```

**Rust:**

```powershell
rustc --edition=2021 Rust/01_vector_stats.rs -o output/bin/r01.exe
if ($LASTEXITCODE -eq 0) { .\output\bin\r01.exe }
```

**Expected output (both languages):**

```text
count: 5
mean: 5.00
maximum: 9
```

#### Program 02 — Account Update

Starts with Ada’s balance of 100, accepts a deposit of 25, and rejects a deposit of -7.

**Fortran:**

```powershell
gfortran -std=f2018 -Wall -Wextra -fcheck=all -J output/build Fortran/02_account_update.f90 -o output/bin/f02.exe
if ($LASTEXITCODE -eq 0) { .\output\bin\f02.exe }
```

**Rust:**

```powershell
rustc --edition=2021 Rust/02_account_update.rs -o output/bin/r02.exe
if ($LASTEXITCODE -eq 0) { .\output\bin\r02.exe }
```

**Expected output (both languages):**

```text
owner: Ada
balance: 125
first deposit accepted: T
negative deposit accepted: F
```

#### Program 03 — Parse Totals

Processes the tokens `12`, `oops`, `7`, `-3`, and `25`, counting accepted and rejected inputs and summing valid integers.

**Fortran:**

```powershell
gfortran -std=f2018 -Wall -Wextra -fcheck=all -J output/build Fortran/03_parse_totals.f90 -o output/bin/f03.exe
if ($LASTEXITCODE -eq 0) { .\output\bin\f03.exe }
```

**Rust:**

```powershell
rustc --edition=2021 Rust/03_parse_totals.rs -o output/bin/r03.exe
if ($LASTEXITCODE -eq 0) { .\output\bin\r03.exe }
```

**Expected output (both languages):**

```text
accepted: 4
rejected: 1
total: 41
```

### Step 3 — Verify the results

Compare the output of each implementation with the expected output shown above. Each Fortran–Rust pair should print the same values. Hyperfine is only needed for the optional benchmark reproduction described later; it is not required to run the six programs.

## Compile and run on Linux/macOS (Bash)

```bash
set -e
mkdir -p output/bin output/build
gfortran --version
rustc --version

# Program 01
gfortran -std=f2018 -Wall -Wextra -fcheck=all -J output/build Fortran/01_vector_stats.f90 -o output/bin/f01
./output/bin/f01
rustc --edition=2021 Rust/01_vector_stats.rs -o output/bin/r01
./output/bin/r01

# Program 02
gfortran -std=f2018 -Wall -Wextra -fcheck=all -J output/build Fortran/02_account_update.f90 -o output/bin/f02
./output/bin/f02
rustc --edition=2021 Rust/02_account_update.rs -o output/bin/r02
./output/bin/r02

# Program 03
gfortran -std=f2018 -Wall -Wextra -fcheck=all -J output/build Fortran/03_parse_totals.f90 -o output/bin/f03
./output/bin/f03
rustc --edition=2021 Rust/03_parse_totals.rs -o output/bin/r03
./output/bin/r03
```

## Verified program output (both languages)

The following outputs were observed for both implementations in the VS Code runs.

**01 — Vector Statistics**

```text
count: 5
mean: 5.00
maximum: 9
```

**02 — Account Update**

```text
owner: Ada
balance: 125
first deposit accepted: T
negative deposit accepted: F
```

**03 — Parse Totals**

```text
accepted: 4
rejected: 1
total: 41
```

## Language-specific constructs

| Pair | Fortran | Rust |
|---|---|---|
| 01 | `MODULE` packages the procedure; `INTENT(IN)` restricts modification through the dummy argument; `SUM`, `SIZE`, and `MAXVAL` operate on arrays; `ISO_FORTRAN_ENV` selects `real64`. | `&[i32]` is a borrowed slice; `Option` represents a possible absent result; iterator methods perform reductions; `?` propagates `None`. |
| 02 | `TYPE` defines a derived record; `INTENT(INOUT)` permits reading and updating the associated account; `HUGE` supports an overflow guard. | `struct` defines the record, `String` owns text, `&mut` grants exclusive mutable access, `checked_add` checks overflow, and `Result` conveys success or failure. |
| 03 | Internal formatted `READ` uses `IOSTAT` to report I/O status; `DO` and `IF` control the validation loop. | `parse::<i32>()` returns a `Result`; `match` handles its `Ok` and `Err` variants. |

## Cross-language baseline benchmarking

The three CSV files contain the Hyperfine wall-clock timing summaries for the original fixed-input programs. The benchmark builds use `-O2` for GNU Fortran and `-C opt-level=2` for Rust (with `--edition=2021`). The procedure uses five warm-up runs and 30 measured runs per executable.

| Program | Results file | Fortran median (ms) | Rust median (ms) |
|---|---|---:|---:|
| Vector Statistics | [vector_results.csv](vector_results.csv) | 24.88 | 21.61 |
| Account Update | [account_results.csv](account_results.csv) | 24.47 | 22.72 |
| Parse Totals | [parse_results.csv](parse_results.csv) | 25.58 | 20.97 |

The CSV files report wall-clock time in seconds, including the mean, standard deviation, median, minimum, and maximum. The table converts the medians to milliseconds. These small-program measurements include process startup and output overhead and do not establish a universal language performance ranking.

### Reproduce the benchmarks (Windows PowerShell)

Install [Hyperfine](https://github.com/sharkdp/hyperfine#installation) and make sure it is on PATH. From the folder containing this README, run:

```powershell
# Optimized builds
New-Item -ItemType Directory -Force output/build | Out-Null
gfortran -std=f2018 -O2 -J output/build Fortran/01_vector_stats.f90 -o f01.exe
if ($LASTEXITCODE -ne 0) { throw "Fortran 01 build failed" }
rustc --edition=2021 -C opt-level=2 Rust/01_vector_stats.rs -o r01.exe
if ($LASTEXITCODE -ne 0) { throw "Rust 01 build failed" }
gfortran -std=f2018 -O2 -J output/build Fortran/02_account_update.f90 -o f02.exe
if ($LASTEXITCODE -ne 0) { throw "Fortran 02 build failed" }
rustc --edition=2021 -C opt-level=2 Rust/02_account_update.rs -o r02.exe
if ($LASTEXITCODE -ne 0) { throw "Rust 02 build failed" }
gfortran -std=f2018 -O2 -J output/build Fortran/03_parse_totals.f90 -o f03.exe
if ($LASTEXITCODE -ne 0) { throw "Fortran 03 build failed" }
rustc --edition=2021 -C opt-level=2 Rust/03_parse_totals.rs -o r03.exe
if ($LASTEXITCODE -ne 0) { throw "Rust 03 build failed" }

# Use new filenames to preserve the submitted measurements
hyperfine --warmup 5 --runs 30 -N "./f01.exe" "./r01.exe" --export-csv vector_retest.csv
hyperfine --warmup 5 --runs 30 -N "./f02.exe" "./r02.exe" --export-csv account_retest.csv
hyperfine --warmup 5 --runs 30 -N "./f03.exe" "./r03.exe" --export-csv parse_retest.csv
```

## Repository structure

```text
Final_Project_Cordero_Villaruel/
├── Fortran/
│   ├── 01_vector_stats.f90
│   ├── 02_account_update.f90
│   └── 03_parse_totals.f90
├── Rust/
│   ├── 01_vector_stats.rs
│   ├── 02_account_update.rs
│   └── 03_parse_totals.rs
├── vector_results.csv
├── account_results.csv
├── parse_results.csv
└── README.md
```


