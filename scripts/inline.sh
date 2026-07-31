#!/bin/bash
set -e

build_files=$(
  git ls-tree -r --name-only HEAD | \
  grep "/BUILD$"
)

echo "Building inliner"

bazel build //bzl/inlinerjs

echo $build_files | xargs -n 100 -P 10 bazel-bin/bzl/inlinerjs/inlinerjs

echo $build_files | xargs buildifier -lint=fix

echo "Done."
