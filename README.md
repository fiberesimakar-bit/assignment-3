# Assignment 3 – DevOps CI/CD Pipeline

## Overview

This assignment demonstrates a basic DevOps CI/CD pipeline using Bash, Docker, and GitHub Actions.

The project contains a diagnostic Bash application, automated tests, linting, Docker support, and a GitHub Actions CI pipeline.

## Project Structure

```text
.
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   └── app.sh
├── scripts/
│   ├── build.sh
│   └── lint.sh
├── tests/
│   └── test.sh
├── .dockerignore
├── compose.yaml
├── Dockerfile
├── grade.sh
└── README.md
## CI Failure and Fix Demonstration

During development, the GitHub Actions CI pipeline was intentionally tested with an invalid Bash syntax change in `app/app.sh`. The CI workflow detected the syntax error and the workflow failed.

The syntax error was then corrected, and the test suite was run again locally. All tests passed and the corrected changes were pushed to GitHub.

The final CI pipeline uses three stages:

1. Validate Bash syntax
2. Run linting and tests
3. Build the Docker image

The final workflow completed successfully after the syntax error was fixed.
