#!/bin/bash

set -e

bash -n app/app.sh

echo "Lint check passed."
