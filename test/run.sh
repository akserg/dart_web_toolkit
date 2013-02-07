#!/bin/bash

set -e

###############
# Type Analysis
###############

echo
echo "dart_analyzer lib/*.dart"

results=$(dart_analyzer lib/*.dart 2>&1 1>/dev/null)

echo "$results"

#if [ -n "$results" ]; then
#    exit 1
#else
#    echo "Passed analysis."
#fi

############
# Unit Tests
############

echo "DumpRenderTree test/index.html"
results=`DumpRenderTree test/index.html 2>&1`

echo "$results" | grep CONSOLE

echo $results | grep 'unittest-suite-success' >/dev/null

echo $results | grep -v 'Exception: Some tests failed.' >/dev/null

