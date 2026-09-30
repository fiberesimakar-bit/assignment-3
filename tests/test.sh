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

echo "Test 3: help command works"
./app/app.sh help >/tmp/help-output.txt
grep -q "Usage:" /tmp/help-output.txt
echo "PASS"

echo "Test 4: system-info command works"
./app/app.sh system-info >/tmp/system-output.txt
grep -q "Hostname:" /tmp/system-output.txt
grep -q "User:" /tmp/system-output.txt
grep -q "Kernel:" /tmp/system-output.txt
echo "PASS"

echo "Test 5: check-host works"
./app/app.sh check-host google.com >/tmp/host-output.txt
grep -q "google.com" /tmp/host-output.txt
echo "PASS"

echo "Test 6: check-port works"
./app/app.sh check-port google.com 443 >/tmp/port-output.txt
grep -q "Port 443" /tmp/port-output.txt
echo "PASS"

echo "Test 7: invalid command returns exit code 2"
set +e
./app/app.sh invalid-command >/tmp/invalid-output.txt 2>&1
status=$?
set -e

test "$status" -eq 2
grep -q "invalid command" /tmp/invalid-output.txt
echo "PASS"

echo "Test 8: lint check passes"
./scripts/lint.sh
echo "PASS"

echo "======================================"
echo "All 8 tests passed."
echo "======================================"
