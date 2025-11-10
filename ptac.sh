#!/usr/bin/env bash

# ptac - The Prepending CAT solution
# A cat-like tool for prepending content to files or output
# Version 1.0

show_help() {
  cat <<EOF
ptac - The Prepending CAT Solution
Prepend content to files or standard output

Usage: ptac [OPTION]... [CONTENT] [FILE]...
       ptac [OPTION]... -f PREPEND_FILE [FILE]...

Prepend CONTENT or content of PREPEND_FILE to FILE(s) or standard output.

If no FILE is specified or FILE is -, read from standard input.

Options:
  -A, --show-all           equivalent to -vET
  -b, --number-nonblank    number nonempty output lines, overrides -n
  -e                       equivalent to -vE
  -E, --show-ends          display \$ at end of each line
  -f, --file FILE          prepend content from FILE
  -n, --number             number all output lines
  -s, --squeeze-blank      suppress repeated empty output lines
  -t                       equivalent to -vT
  -T, --show-tabs          display TAB characters as ^I
  -u                       (ignored)
  -v, --show-nonprinting   use ^ and M- notation, except for LFD and TAB
  --help                   display this help and exit
  --version                output version information and exit

Examples:
  ptac "Header line" file.txt          # Prepend string to file content
  ptac -f header.txt file.txt          # Prepend file content
  ptac -n "Line " file.txt             # Prepend with line numbers
  echo "data" | ptac "Header:"         # Prepend to stdin
  ptac "Start:" file1.txt file2.txt    # Prepend to multiple files

Note: When prepending to multiple files, each file gets the same prepended content.
EOF
}

show_version() {
  echo "ptac 1.0 - The Prepending CAT Solution"
  echo "License: MIT"
}

# Initialize variables
SHOW_ALL=0
NUMBER_NONBLANK=0
SHOW_ENDS=0
NUMBER=0
SQUEEZE_BLANK=0
SHOW_TABS=0
SHOW_NONPRINTING=0
PREPEND_FILE=""
PREPEND_CONTENT=""
FILES=()
CONTENT_PROVIDED=0

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
  -A | --show-all)
    SHOW_ALL=1
    shift
    ;;
  -b | --number-nonblank)
    NUMBER_NONBLANK=1
    shift
    ;;
  -e)
    SHOW_NONPRINTING=1
    SHOW_ENDS=1
    shift
    ;;
  -E | --show-ends)
    SHOW_ENDS=1
    shift
    ;;
  -f | --file)
    if [[ -z "$2" ]]; then
      echo "ptac: option requires an argument -- '$1'" >&2
      exit 1
    fi
    PREPEND_FILE="$2"
    shift 2
    ;;
  -n | --number)
    NUMBER=1
    shift
    ;;
  -s | --squeeze-blank)
    SQUEEZE_BLANK=1
    shift
    ;;
  -t)
    SHOW_NONPRINTING=1
    SHOW_TABS=1
    shift
    ;;
  -T | --show-tabs)
    SHOW_TABS=1
    shift
    ;;
  -u)
    # Ignored for compatibility
    shift
    ;;
  -v | --show-nonprinting)
    SHOW_NONPRINTING=1
    shift
    ;;
  --help)
    show_help
    exit 0
    ;;
  --version)
    show_version
    exit 0
    ;;
  --)
    shift
    while [[ $# -gt 0 ]]; do
      FILES+=("$1")
      shift
    done
    ;;
  -*)
    echo "ptac: invalid option -- '$1'" >&2
    echo "Try 'ptac --help' for more information." >&2
    exit 1
    ;;
  *)
    if [[ $CONTENT_PROVIDED -eq 0 && -z "$PREPEND_FILE" ]]; then
      PREPEND_CONTENT="$1"
      CONTENT_PROVIDED=1
    else
      FILES+=("$1")
    fi
    shift
    ;;
  esac
done

# Validate arguments
if [[ -n "$PREPEND_FILE" && -n "$PREPEND_CONTENT" ]]; then
  echo "ptac: cannot specify both content string and prepend file" >&2
  exit 1
fi

if [[ -z "$PREPEND_FILE" && -z "$PREPEND_CONTENT" ]]; then
  echo "ptac: must specify content to prepend with -f or content string" >&2
  echo "Try 'ptac --help' for more information." >&2
  exit 1
fi

if [[ -n "$PREPEND_FILE" && ! -f "$PREPEND_FILE" ]]; then
  echo "ptac: cannot open '$PREPEND_FILE': No such file or directory" >&2
  exit 1
fi

# Function to process content with options
process_content() {
  local content="$1"

  # Handle squeeze blank
  if [[ $SQUEEZE_BLANK -eq 1 ]]; then
    content=$(echo "$content" | cat -s)
  fi

  # Handle numbering
  if [[ $NUMBER_NONBLANK -eq 1 ]]; then
    content=$(echo "$content" | cat -b)
  elif [[ $NUMBER -eq 1 ]]; then
    content=$(echo "$content" | cat -n)
  fi

  # Handle show options
  if [[ $SHOW_ALL -eq 1 ]]; then
    content=$(echo "$content" | cat -A)
  else
    if [[ $SHOW_ENDS -eq 1 ]]; then
      content=$(echo "$content" | cat -E)
    fi
    if [[ $SHOW_TABS -eq 1 ]]; then
      content=$(echo "$content" | cat -T)
    fi
    if [[ $SHOW_NONPRINTING -eq 1 ]]; then
      content=$(echo "$content" | cat -v)
    fi
  fi

  echo "$content"
}

# Function to prepend to a file or stream
prepend_to_target() {
  local target="$1"
  local prepend_content="$2"

  if [[ "$target" == "-" || -z "$target" ]]; then
    # Read from stdin
    local main_content
    main_content=$(cat)
    printf "%s\n%s" "$prepend_content" "$main_content"
  else
    if [[ ! -f "$target" ]]; then
      echo "ptac: cannot open '$target': No such file or directory" >&2
      return 1
    fi

    local main_content
    main_content=$(cat "$target")
    printf "%s\n%s" "$prepend_content" "$main_content"
  fi
}

# Get the content to prepend
if [[ -n "$PREPEND_FILE" ]]; then
  PREPEND_CONTENT=$(cat "$PREPEND_FILE")
fi

# Process the prepend content with the specified options
PREPEND_CONTENT=$(process_content "$PREPEND_CONTENT")

# Handle the files or stdin
if [[ ${#FILES[@]} -eq 0 ]]; then
  # No files specified, use stdin
  prepend_to_target "" "$PREPEND_CONTENT"
else
  # Process each file
  for file in "${FILES[@]}"; do
    if [[ ${#FILES[@]} -gt 1 ]]; then
      echo "==> Prepending to $file <=="
    fi
    prepend_to_target "$file" "$PREPEND_CONTENT"
    if [[ ${#FILES[@]} -gt 1 ]]; then
      echo
    fi
  done
fi
