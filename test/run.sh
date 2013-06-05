#!/bin/bash

set -e

###############
# Type Analysis
###############

echo "Analyse code..."

output=$(dart_analyzer --extended-exit-code lib/*.dart 2>&1)
results=$?

if [ "$results" -ne 0 ]; then
    exit 1
else
   echo "Passed analysis."
fi

############
# Unit Tests
############

#echo "Run tests..."

#results=$(DumpRenderTree test/index.html 2>&1)

#echo "------------------"
#echo "$results" | grep FAILED
#echo "------------------"

#if grep -q "Exception: Some tests failed." <<<$results; then
#  exit 1
#else
#  echo "Passed tests."
#fi
