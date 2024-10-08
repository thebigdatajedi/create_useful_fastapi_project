#!/bin/bash

# Check if project name is passed as argument
if [ -z "$1" ]; then
  echo "Error: No project name provided."
  echo "Usage: ./test_script.sh <project_name>"
  exit 1
fi

# Variables
PROJECT_NAME=$1
CREATE_SCRIPT="create_useful_fastapi_project.sh"
CLEANUP_SCRIPT="full_clean_up_script_in_case_others_add_to_script_they_can_easily_test.sh"
PARENT_DIR=".."

# Copy scripts to the parent directory
echo "Copying $CREATE_SCRIPT and $CLEANUP_SCRIPT to $PARENT_DIR..."
cp $CREATE_SCRIPT $PARENT_DIR/
cp $CLEANUP_SCRIPT $PARENT_DIR/

# Navigate to the parent directory
cd $PARENT_DIR || { echo "Failed to navigate to parent directory."; exit 1; }

# Run the create project script
echo "Running $CREATE_SCRIPT..."
./$CREATE_SCRIPT $PROJECT_NAME

# Check if the directory structure is correct
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

# Optionally, run the cleanup script after testing
read -p "Do you want to run the cleanup script? (Y/n): " run_cleanup
if [[ "$run_cleanup" =~ ^[Yy]$ ]] || [[ -z "$run_cleanup" ]]; then
  echo "Running $CLEANUP_SCRIPT..."
  ./$CLEANUP_SCRIPT
fi

echo "Test script completed."