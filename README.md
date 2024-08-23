# Create Useful FastAPI Project

Welcome to the **Create Useful FastAPI Project**! This project provides a set of scripts that help you quickly and efficiently set up a FastAPI project with a well-structured directory layout. Whether you're working on a solo project or collaborating with others, this tool is designed to save you time and ensure your project is organized from the start.

## Project Structure

When you run the script, it will generate a project with the following directory structure:

```plaintext
<project_name>/
├── app/
│   ├── __init__.py
│   ├── main.py
│   ├── models.py
│   ├── services.py
│   ├── logging_config.py
│   ├── routers/
│   │   ├── __init__.py
│   │   ├── dashboard.py
│   ├── db/
│   │   ├── __init__.py
│   │   ├── session.py
│   ├── core/
│   │   ├── __init__.py
│   │   ├── config.py
├── tests/
│   ├── __init__.py
│   ├── test_connector_status.py
│   ├── test_dashboard.py
├── alembic/
│   ├── versions/
│   ├── env.py
│   ├── script.py.mako
├── alembic.ini
├── README.md
├── .gitignore
```

This structure ensures that your project is clean, organized, and ready for development with FastAPI.

## How It Works

### 1. **`create_useful_fastapi_project.sh`**
- **Purpose**: This script is the main driver that sets up your FastAPI project.
- **Usage**:
  ```bash
  ./create_useful_fastapi_project.sh <your_project_name>
  ```
- **What It Does**:
    - **Creates the directory structure**: As shown above, this script will create all the necessary directories and files to get started.
    - **Checks for Poetry**: The script ensures Poetry is installed on your system, installing it if necessary.
    - **Initializes the project**: Using Poetry, the script initializes the project with the required dependencies like FastAPI, Uvicorn, SQLModel, and more.
    - **Generates a `.gitignore` file**: To keep your project clean, a basic `.gitignore` is created.

### 2. **`full_clean_up_script_in_case_others_add_to_script_they_can_easily_test.sh`**
- **Purpose**: This script is designed to clean up everything that was set up by the project creation script. This is especially useful for developers who need to repeatedly test the project setup.
- **Usage**:
  ```bash
  ./full_clean_up_script_in_case_others_add_to_script_they_can_easily_test.sh
  ```
- **What It Does**:
    - **Removes installed dependencies**: It will remove Poetry, tree, and any other tools installed during the setup.
    - **Deletes the project directory**: The entire project directory created by the script will be removed, ensuring your system is left clean.

### 3. **`unit_structure_test.sh`**
- **Purpose**: This script is a core part of the CI pipeline. It verifies the directory and file structure of the project to ensure everything is in place.
- **Usage**: Automatically triggered in the CI pipeline.
- **What It Does**:
    - **Verifies the structure**: The script checks for the existence of all the expected directories and files.
    - **Runs independently**: This script is intended to run on its own in the CI pipeline to validate that the project structure adheres to the expected format.

### 4. **`local_dev_test.sh`**
- **Purpose**: This script is for local development testing. It allows developers to test their code changes by setting up a temporary project with a unique name, running tests, and then cleaning up afterward.
- **Usage**:
  ```bash
  ./local_dev_test.sh
  ```
- **What It Does**:
    - **Switches to the parent directory**: To avoid cluttering the source directory, this script changes to the parent directory (one level up).
    - **Generates a random project name**: It creates a project with a unique name using a random hash, so you can run multiple tests without conflict.
    - **Runs the unit tests**: It triggers the `unit_structure_test.sh` script to verify the project setup.
    - **Cleans up after testing**: Once the tests are completed, the script removes the temporary project directory, ensuring your workspace remains tidy.

## License

This project is licensed under the MIT License, meaning you are free to use, modify, and distribute it as you see fit. We encourage contributions—whether you're fixing a bug, adding a feature, or improving documentation.

### Contributing

We welcome contributions from the community! Here's how you can contribute:

1. **Fork the Repository**: Create your own copy of the project by forking the repository.
2. **Clone Your Fork**: Clone your forked repository to your local machine.
3. **Make Changes**: Create a new branch and make your changes.
4. **Run Tests**: Use `local_dev_test.sh` to ensure your changes don't break anything.
5. **Submit a Pull Request**: Push your changes to your fork and submit a pull request to the main repository. We'll review your changes and merge them if everything looks good.

We aim to make this tool as useful and user-friendly as possible. If you have any suggestions, feel free to open an issue or submit a pull request!

---

We hope you find this project helpful for your FastAPI development! Happy coding!

**Creation Data-Time Zulu Time:** 2024-08-20T15:45:00Z

