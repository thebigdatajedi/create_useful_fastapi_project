#!/bin/zsh

# Script variables
CREATE_SCRIPT="create_useful_fastapi_project.sh"
CLEANUP_SCRIPT="full_clean_up_script_in_case_others_add_to_script_they_can_easily_test.sh"
TEST_SCRIPT="unit_structure_test.sh"
PARENT_DIR=".."

# Function to generate a random hash for the project name
generate_random_hash() {
  echo "$(date +%s | sha256sum | base64 | head -c 8)"
}

# Copy the create, cleanup, and test scripts to the parent directory
echo "Copying $CREATE_SCRIPT, $CLEANUP_SCRIPT, and $TEST_SCRIPT to $PARENT_DIR..."
cp $CREATE_SCRIPT $PARENT_DIR/
cp $CLEANUP_SCRIPT $PARENT_DIR/
cp $TEST_SCRIPT $PARENT_DIR/

# Ensure all scripts are executable
echo "Setting execute permissions for all scripts..."
chmod +x $CREATE_SCRIPT
chmod +x $CLEANUP_SCRIPT
chmod +x $TEST_SCRIPT
chmod +x $(basename "$0")  # Make local_dev_test.sh executable

# Generate a random hash for the project name
RANDOM_HASH=$(generate_random_hash)
PROJECT_NAME="project_$RANDOM_HASH"

echo "Generated random project name: $PROJECT_NAME"

# Run the create script with the random project name
echo "Running $CREATE_SCRIPT with project name: $PROJECT_NAME..."
cd $PARENT_DIR || { echo "Failed to navigate to parent directory."; exit 1; }
./$CREATE_SCRIPT $PROJECT_NAME

# Run the test script with the generated project name
echo "Running $TEST_SCRIPT with project name: $PROJECT_NAME..."
./$TEST_SCRIPT $PROJECT_NAME

echo "Local development test completed."