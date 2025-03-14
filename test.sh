#!/bin/bash

# Simulate GitHub environment variables
export ENV_VAR_ONE="value1"
export ENV_VAR_THREE="value2"

# Save input to a JSON file
echo '["ENV_VAR_ONE", "ENV_VAR_THREE"]' > github_env_vars.json

# Debugging to check the content of the file
echo "Contents of github_env_vars.json:"
cat github_env_vars.json

# Loop through each variable from the JSON array
jq -c '.[]' github_env_vars.json | while IFS= read -r var_name; do
  echo "Found variable name: $var_name" 

  # Check if the GitHub environment variable exists
  var_value=$(printenv "$var_name")
  echo "Fetched value for $var_name: $var_value"  

  # If the variable is not empty, simulate adding it to GITHUB_ENV
  if [ -n "$var_value" ]; then
    echo "Setting $var_name=$var_value"
  else
    echo "Warning: $var_name is not set"
  fi
done
