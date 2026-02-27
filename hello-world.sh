
#!/bin/bash

# Initialize variables
NAME="World"
VERBOSE=0

# Use getopts in a while loop
# The optstring "n:v" defines the accepted flags. 
# A colon (:) after a flag (like 'n:') means it requires an argument.
while getopts "n:v" arg; do
  case $arg in
    n)
      NAME=$OPTARG # OPTARG is a built-in variable holding the flag's argument
      ;;
    v)
      VERBOSE=1 # Set the verbose flag to true
      ;;
    \?) # Handle illegal options
      echo "Error: Invalid option -$OPTARG" >&2
      exit 1
      ;;
  esac
done

# Shift the positional parameters so that any remaining arguments (non-flag) can be accessed normally
shift $((OPTIND - 1))

# Main script logic using the flags
if [ $VERBOSE -eq 1 ]; then
  echo "Verbose mode enabled."
fi

echo "Hello, $NAME!"
