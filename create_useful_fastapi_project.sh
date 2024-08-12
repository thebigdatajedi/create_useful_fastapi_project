#!/bin/zsh

# Check if project name is passed as argument
if [ -z "$1" ]; then
  echo "Error: No project name provided."
  echo "Usage: ./create_useful_fastapi_project.sh <project_name>"
  exit 1
fi

PROJECT_NAME=$1

echo "Creating project directory $PROJECT_NAME..."

# Create project directory
mkdir -p $PROJECT_NAME

# Check if the directory was created
if [ ! -d "$PROJECT_NAME" ]; then
  echo "Error: Failed to create project directory."
  exit 1
fi

echo "Creating directory structure..."

# Create directory structure
mkdir -p $PROJECT_NAME/{app/{routers,db,core},tests,alembic/versions}
touch $PROJECT_NAME/{app/{__init__.py,main.py,models.py,services.py,logging_config.py,routers/__init__.py,routers/dashboard.py,db/__init__.py,db/session.py,core/__init__.py,core/config.py},tests/{__init__.py,test_connector_status.py,test_dashboard.py},alembic/{env.py,script.py.mako},alembic.ini,README.md,.gitignore}

echo "Checking if Poetry is installed..."

# Check if Poetry is installed, and install if necessary
if ! command -v poetry &> /dev/null
then
  echo "Poetry could not be found, installing..."
  curl -sSL https://install.python-poetry.org | python3 -
  export PATH="$HOME/.poetry/bin:$PATH"
else
  echo "Poetry is already installed."
fi

echo "Initializing Poetry project..."

# Initialize Poetry project
poetry init -n --name "$PROJECT_NAME" --dependency fastapi --dependency uvicorn --dependency sqlmodel --dependency requests --dependency psycopg2-binary --dependency alembic --dev-dependency pytest

echo "Activating virtual environment..."

# Activate the virtual environment
poetry shell

echo "Installing dependencies..."

# Install the dependencies
poetry install

echo "Adding .gitignore content..."

# Add .gitignore content (optional)
cat <<EOT >> .gitignore
__pycache__/
*.py[cod]
*.so
*.egg-info/
.venv/
poetry.lock
EOT

echo "Project $PROJECT_NAME has been created successfully with the following structure:"
tree -a $PROJECT_NAME