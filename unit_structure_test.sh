#!/bin/zsh

if [ -z "$1" ]; then
  echo "Error: No project name provided."
  exit 1
fi

PROJECT_NAME=$1

echo "Verifying directory and file structure..."

check_structure() {
  local expected_path=$1
  if [ -e "$expected_path" ]; then
    echo "OK: $expected_path exists."
  else
    echo "FAIL: $expected_path does not exist."
  fi
}

# List of directories and files to check
declare -a DIRS_AND_FILES=(
  "$PROJECT_NAME"
  "$PROJECT_NAME/app"
  "$PROJECT_NAME/app/routers"
  "$PROJECT_NAME/app/db"
  "$PROJECT_NAME/app/core"
  "$PROJECT_NAME/tests"
  "$PROJECT_NAME/alembic/versions"
  "$PROJECT_NAME/alembic/env.py"
  "$PROJECT_NAME/alembic/script.py.mako"
  "$PROJECT_NAME/alembic.ini"
  "$PROJECT_NAME/README.md"
  "$PROJECT_NAME/.gitignore"
  "$PROJECT_NAME/app/__init__.py"
  "$PROJECT_NAME/app/main.py"
  "$PROJECT_NAME/app/models.py"
  "$PROJECT_NAME/app/services.py"
  "$PROJECT_NAME/app/logging_config.py"
  "$PROJECT_NAME/app/routers/__init__.py"
  "$PROJECT_NAME/app/routers/dashboard.py"
  "$PROJECT_NAME/app/db/__init__.py"
  "$PROJECT_NAME/app/db/session.py"
  "$PROJECT_NAME/app/core/__init__.py"
  "$PROJECT_NAME/app/core/config.py"
  "$PROJECT_NAME/tests/__init__.py"
  "$PROJECT_NAME/tests/test_connector_status.py"
  "$PROJECT_NAME/tests/test_dashboard.py"
)

# Loop through the list and check each one
for item in "${DIRS_AND_FILES[@]}"; do
  check_structure "$item"
done

echo "Verification completed."