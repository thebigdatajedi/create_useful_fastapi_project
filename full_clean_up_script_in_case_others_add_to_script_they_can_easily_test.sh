#!/bin/zsh

echo "Starting full cleanup process..."

# Function to confirm the removal
confirm_removal() {
  read -p "Do you want to remove $1? (Y/n): " choice
  case "$choice" in
    y|Y|"" ) echo "Removing $1..."; return 0;;
    n|N ) echo "Skipping $1 removal."; return 1;;
    * ) echo "Invalid option. Please choose Y or n."; confirm_removal $1;;
  esac
}

# Remove Poetry
if command -v poetry &> /dev/null
then
  if confirm_removal "Poetry"; then
    echo "Removing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 - --uninstall
    rm -rf $HOME/.poetry
    echo "Poetry has been removed."
  fi
else
  echo "Poetry is not installed."
fi

# Remove tree
if command -v tree &> /dev/null
then
  if confirm_removal "tree"; then
    echo "Removing tree..."
    brew uninstall tree
    echo "tree has been removed."
  fi
else
  echo "tree is not installed."
fi

# Remove Homebrew and associated packages
if command -v brew &> /dev/null
then
  if confirm_removal "Homebrew"; then
    echo "Removing Homebrew and all installed packages..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
    sudo rm -rf /usr/local/Homebrew
    sudo rm -rf /opt/homebrew
    echo "Homebrew and all packages have been removed."
  fi
else
  echo "Homebrew is not installed."
fi

# Remove virtual environment if exists
if [ -d ".venv" ]; then
  if confirm_removal "the virtual environment (.venv)"; then
    echo "Removing virtual environment..."
    rm -rf .venv
    echo "Virtual environment has been removed."
  fi
else
  echo "No virtual environment found."
fi

# Remove project directory if specified
read -p "Do you want to remove the project directory? (Y/n): " remove_project
if [[ "$remove_project" =~ ^[Yy]$ ]] || [[ -z "$remove_project" ]]; then
  read -p "Enter the project directory name you want to remove: " project_dir
  if [ -d "$project_dir" ]; then
    echo "Removing project directory $project_dir..."
    rm -rf "$project_dir"
    echo "Project directory $project_dir has been removed."
  else
    echo "Project directory $project_dir not found."
  fi
else
  echo "Skipping project directory removal."
fi

echo "Full cleanup process completed."