#!/bin/bash

set -e

echo "======================================"
echo " Assignment 3 Tests"
echo "======================================"

echo "Test 1: app.sh exists"
test -f app/app.sh
echo "PASS"

echo "Test 2: app.sh is executable"
test -x app/app.sh
echo "PASS"

echo "Test 3: app.sh runs successfully"
./app/app.sh > /tmp/app-output.txt
echo "PASS"

echo "Test 4: greeting is correct"
grep -q "Hello from Assignment 3!" /tmp/app-output.txt
echo "PASS"

echo "Test 5: CI/CD message is correct"
grep -q "DevOps CI/CD pipeline is working." /tmp/app-output.txt
echo "PASS"

echo "Test 6: output is not empty"
test -s /tmp/app-output.txt
echo "PASS"

echo "Test 7: lint script exists"
test -f scripts/lint.sh
echo "PASS"

echo "Test 8: lint check passes"
./scripts/lint.sh
echo "PASS"

echo "======================================"
echo "All 8 tests passed."
echo "======================================"