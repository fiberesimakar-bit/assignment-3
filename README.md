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
