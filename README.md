# RTKSwift

Small SwiftPM fixtures used to exercise **[RTK](https://github.com/rtk-ai/rtk)** (`rtk swift build` / `rtk swift test`): happy-path compression, failure paths, and rough token savings.

## Requirements

- Swift 6.x (SwiftPM). The root package declares `swift-tools-version: 6.3`.
- **RTK** (optional, for filtered runs): build from a clone, e.g. `cargo install --path .` from the rtk repo, or use `path/to/rtk/target/release/rtk` after `cargo build --release`.

## Positive (root package)

From the **repository root** (`RTKSwift/`):

```bash
swift build
swift test
swift test --parallel
# or
./scripts/run-positive.sh
```

With RTK (same working directory):

```bash
rtk swift build
rtk swift test
rtk swift test --parallel
```

On success, RTK prints one line each:

- **`ok (build complete)`**
- **`ok (all tests passed)`**

Exit code is **0**, same as plain `swift`.

## Token savings (approximate)

RTK is meant to cut what you paste into an LLM. A practical proxy is **whitespace word count** on captured output (not identical to a model tokenizer, but trends match).

On this repo’s root package, typical figures are in this range:

| Command                 | Rough savings vs raw `swift`                                              |
| ----------------------- | ------------------------------------------------------------------------- |
| `swift build`           | often **~80–90%** when the build is clean and output is short             |
| `swift test`            | often **~90–97%** on green runs (XCTest + Swift Testing banners collapse) |
| `swift test --parallel` | often **~90%+** on green runs                                             |

Reproduce locally (example):

```bash
cd /path/to/RTKSwift
rm -rf .build
echo "build:  raw $(swift build 2>&1 | wc -w) words, rtk $(rtk swift build 2>&1 | wc -w) words"
rm -rf .build
echo "test:   raw $(swift test 2>&1 | wc -w) words, rtk $(rtk swift test 2>&1 | wc -w) words"
```

**Failures:** RTK keeps diagnostics and exits with the same non-zero code as `swift`; savings on red paths are **much lower** by design.

If RTK tees full output on failure, it prints a line pointing at a log under the RTK data directory (see `rtk` docs / `tee` hint).

## Negative build

Sub-package with a **compile-time** error (`Fixtures/NegativeBuild/`):

```bash
cd Fixtures/NegativeBuild
swift build
# or from repo root:
./scripts/run-negative-build.sh
```

Expect **non-zero** exit; `rtk swift build` should still surface the compiler error.

## Negative test

Sub-package with a **failing** Swift Testing case (`Fixtures/NegativeTest/`):

```bash
cd Fixtures/NegativeTest
swift test
# or from repo root:
./scripts/run-negative-test.sh
```

Expect **non-zero** exit; `rtk swift test` should still surface the failure.

## Layout

| Path                      | Role                                                               |
| ------------------------- | ------------------------------------------------------------------ |
| `Sources/RTKSwift/`       | Library used for **positive** build/test                           |
| `Tests/RTKSwiftTests/`    | Passing Swift Testing tests                                        |
| `Fixtures/NegativeBuild/` | Intentional compile error → failed **`swift build`**               |
| `Fixtures/NegativeTest/`  | Intentional failing `#expect` → failed **`swift test`**            |
| `scripts/`                | `run-positive.sh`, `run-negative-build.sh`, `run-negative-test.sh` |

## Quick RTK smoke

```bash
RTK=/path/to/rtk/target/release/rtk
cd /path/to/RTKSwift
"$RTK" swift build && "$RTK" swift test
"$RTK" swift build  # in Fixtures/NegativeBuild — expect failure
"$RTK" swift test   # in Fixtures/NegativeTest — expect failure
```
