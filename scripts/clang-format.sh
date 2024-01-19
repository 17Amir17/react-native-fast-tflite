#!/bin/bash

if which clang-format >/dev/null; then
  find cpp ios android/src/main/cpp -type f \( -name "*.h" -o -name "*.cpp" -o -name "*.m" -o -name "*.mm" \) -print0 | while read -d $'\0' file; do
    if [[ $file == *".framework"* ]]; then
      # Ignore iOS TensorFlow base library
      continue
    fi
    if [[ $file == *"/lib/"* ]]; then
      # Ignore Android TensorFlow base library
      continue
    fi
    echo "-> cpp-lint $file"
    clang-format -i "$file"
  done
else
  echo "warning: clang-format not installed, download from https://clang.llvm.org/docs/ClangFormat.html (or run brew install clang-format)"
fi
