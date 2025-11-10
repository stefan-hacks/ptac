```markdown
# PTAC - The Prepending CAT Solution

`ptac` is a powerful command-line tool that extends the functionality 
of the classic `cat` command with a focus on prepending content to files or standard output. 
It maintains full compatibility with all standard `cat` options while 
adding specialized prepending capabilities.

## Features

- ✅ **Full cat compatibility**: Supports all standard `cat` options
- ✅ **Flexible prepending**: Prepend strings or file content
- ✅ **Multiple file support**: Process one or many files simultaneously
- ✅ **Stream friendly**: Works seamlessly with pipes and stdin/stdout
- ✅ **Professional output**: Proper formatting and error handling
- ✅ **Comprehensive documentation**: Manpage and help system

## Installation

### Quick Install (Bash)

```bash
# Download the ptac script
mkdir -p $HOME/.local/bin
curl -o $HOME/.local/bin/ptac https://raw.githubusercontent.com/stefan-hacks/ptac/main/ptac.sh  
chmod +x $HOME/.local/bin/ptac

```
```

```

## Usage

### Basic Syntax

```bash
ptac [OPTIONS] [CONTENT] [FILES...]
ptac [OPTIONS] -f PREPEND_FILE [FILES...]
```

### Common Examples

#### Prepend Strings
```bash
# Prepend a simple header
ptac "=== Header ===" file.txt

# Prepend to multiple files
ptac "Copyright 2024" *.txt

# Prepend with line numbers
ptac -n "Line " document.txt
```

#### Prepend Files
```bash
# Prepend content from another file
ptac -f header.txt content.txt

# Prepend license to source files
ptac -f LICENSE *.py
```

#### Working with Streams
```bash
# Prepend to stdin
echo "world" | ptac "Hello "

# Prepend timestamp to logs
tail -f app.log | ptac "$(date): "

# Chain with other commands
ptac "START" data.txt | grep "error" | ptac "ERRORS:"
```

#### Advanced Formatting
```bash
# Show non-printing characters
ptac -v "Header\tLine" file.txt

# Display line endings
ptac -E "Header$" file.txt

# Squeeze blank lines
ptac -s "Header" file.txt
```

### Real-World Use Cases

```bash
# Add CSV headers
ptac "id,name,email,date" data.csv

# Prepend configuration sections
ptac -n "# Section " config.txt

# Add timestamps to logs
ptac "[$(date +%Y-%m-%d)] " server.log

# Batch process multiple files
for file in *.js; do
    ptac -f license_header.js "$file" > "licensed_$file"
done
```

## Command Options

| Option | Description |
|--------|-------------|
| `-A, --show-all` | Equivalent to `-vET` |
| `-b, --number-nonblank` | Number non-empty lines |
| `-e` | Equivalent to `-vE` |
| `-E, --show-ends` | Display `$` at line ends |
| `-f, --file FILE` | Prepend content from FILE |
| `-n, --number` | Number all output lines |
| `-s, --squeeze-blank` | Suppress repeated empty lines |
| `-t` | Equivalent to `-vT` |
| `-T, --show-tabs` | Display tabs as `^I` |
| `-v, --show-nonprinting` | Show non-printing characters |
| `--help` | Display help information |
| `--version` | Show version information |


### Get Help
```bash
ptac --help
```

## Compatibility

`ptac` is compatible with:
- Linux distributions
- macOS
- BSD systems
- Other Unix-like environments

## Troubleshooting

### Command Not Found
```bash
# Ensure /usr/local/bin is in your PATH
echo $PATH
# If missing, add to your ~/.bashrc or ~/.zshrc:
export PATH="$PATH:$HOME/.local/bin"
```

```

## Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for bugs and feature requests.

## License

MIT License - see LICENSE file for details.

## See Also

- `cat(1)` - The original concatenate utility
- `tac(1)` - Reverse cat utility
- `head(1)`, `tail(1)` - Display file beginnings/endings
```

