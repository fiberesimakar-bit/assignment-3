#!/bin/bash

set -u

PASS=0
FAIL=0

check() {
    if "$@"; then
        echo "PASS: $*"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $*"
        FAIL=$((FAIL + 1))
    fi
}

echo "================================="
echo " Assignment 3 Grader"
echo "================================="

echo
echo "Checking required files..."

for file in \
    README.md \
    app/app.sh \
    scripts/lint.sh \
    scripts/build.sh \
    tests/test.sh \
    .github/workflows/ci.yml \
    Dockerfile \
    compose.yaml \
    .dockerignore \
    grade.sh
do
    if [ -f "$file" ]; then
        echo "PASS: $file exists"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $file missing"
        FAIL=$((FAIL + 1))
    fi
done

echo
echo "Checking executable permissions..."

for file in app/app.sh scripts/lint.sh scripts/build.sh tests/test.sh grade.sh
do
    if [ -x "$file" ]; then
        echo "PASS: $file executable"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $file is not executable"
        FAIL=$((FAIL + 1))
    fi
done

echo
echo "Checking Bash syntax..."

for file in app/app.sh scripts/lint.sh scripts/build.sh tests/test.sh grade.sh
do
    if bash -n "$file"; then
        echo "PASS: $file syntax"
        PASS=$((PASS + 1))
    else
        echo "FAIL: $file syntax"
        FAIL=$((FAIL + 1))
    fi
done

echo
echo "Checking application..."

check ./app/app.sh help
check ./app/app.sh system-info
check ./app/app.sh check-host google.com
check ./app/app.sh check-port google.com 443

echo
echo "Checking invalid command..."

./app/app.sh invalid-command >/dev/null 2>&1
status=$?

if [ "$status" -eq 2 ]; then
    echo "PASS: invalid command returns exit code 2"
    PASS=$((PASS + 1))
else
    echo "FAIL: invalid command returned $status instead of 2"
    FAIL=$((FAIL + 1))
fi

echo
echo "Checking student tests..."

if ./tests/test.sh; then
    echo "PASS: tests/test.sh"
    PASS=$((PASS + 1))
else
    echo "FAIL: tests/test.sh"
    FAIL=$((FAIL + 1))
fi

echo
echo "Checking lint..."

if ./scripts/lint.sh; then
    echo "PASS: lint.sh"
    PASS=$((PASS + 1))
else
    echo "FAIL: lint.sh"
    FAIL=$((FAIL + 1))
fi

echo
echo "Checking Docker build..."

if docker build -t devops-tool .; then
    echo "PASS: Docker build"
    PASS=$((PASS + 1))
else
    echo "FAIL: Docker build"
    FAIL=$((FAIL + 1))
fi

echo
echo "Checking Docker help..."

if docker run --rm devops-tool help; then
    echo "PASS: Docker help"
    PASS=$((PASS + 1))
else
    echo "FAIL: Docker help"
    FAIL=$((FAIL + 1))
fi

echo
echo "Checking Git history..."

if git log --oneline -5 >/dev/null 2>&1; then
    echo "PASS: Git history available"
    PASS=$((PASS + 1))
else
    echo "FAIL: Git history unavailable"
    FAIL=$((FAIL + 1))
fi

echo
echo "================================="
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo "================================="

if [ "$FAIL" -eq 0 ]; then
    echo "Assignment 3 grader: PASS"
    exit 0
else
    echo "Assignment 3 grader: FAIL"
    exit 1
fi
