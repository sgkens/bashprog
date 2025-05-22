#!/bin/bash
source ./entry.sh

# This function asserts that the previous command has failed (with exit code 1)
assert_function() {
    local exit_code=$?
    local name=$1
    local command_description=$2
   
    if [[ $exit_code -eq 1 ]]; then
        echo "$(clstring "Test Failure" "red") : $(clstring "$name" "cyan") - ${command_description:-'(no description provided)'}"
        exit 1  # Exit the script with failure, which would fail a pipeline run
    else
        echo "$(clstring "Test Success" "green") : $(clstring "$name" "cyan") - Command succeeded as expected with exit code $exit_code: ${command_description:-'(no description provided)'}"
        return 0  # Return success for the assertion itself
    fi
}

# For completeness, here's a version that looks for any failure, not just exit code 1
assert_any_failure() {
    local exit_code=$?
    local name=$1
    local command_description=$2
    if [[ $exit_code -eq 1 || $? -eq 1 ]]; then
        echo "$(clstring "Test Failure" "red") : $(clstring "$name" "cyan") - ${command_description:-'(no description provided)'}"
        exit 1  # Exit the script with failure, which would fail a pipeline run
    else
        echo "$(clstring "Test Success" "green") : $(clstring "$name" "cyan") - Command succeeded as expected: exit code $exit_code: ${command_description:-'(no description provided)'}"
        return 0  # Return success for the assertion itself
    fi
}

# Example usage:
echo "Running tests..."

# Test 1: This should pass as the command will fail with exit code 1
# ls /nonexistent_directory
# assert_function "ls on nonexistent directory" "ls /nonexistent_directory and redirect stderr to /dev/null"

# # Test 2: Test with a command that should exit with code 1
# grep "pattern" /nonexistent_file
# assert_function "grep nonexistent file" "grep should fail with exit code 1"

# # Example of using assert_any_failure (looks for any non-zero exit code)
# false  # Will exit with code 1
# assert_any_failure "false command" "false always exits with code 1"

# # If using these tests in a pipeline, you might want to summarize at the end

# test entry function switch points
echo "Testing Bashprog entry function switch points"
# Test 1: This should pass as the command will fail with exit code 1
bashprog --list
assert_any_failure "bashprog bar" "bashprog --bar arrowflow 75 30"

# # Test 2: This should pass as the command will fail with exit code 1
# bashprog --spinner anglafafs 75 30
# assert_any_failure "bashprog spinner" "bashprog --spinner bits 75 30"
