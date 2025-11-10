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
sudo curl -o /usr/local/bin/ptac https://raw.githubusercontent.com/stefan-hacks/ptac/main/ptac
sudo chmod +x /usr/local/bin/ptac

# Download and install the manpage
sudo curl -o /usr/local/share/man/man1/ptac.1 https://raw.githubusercontent.com/stefan-hacks/ptac/main/ptac.1
sudo mandb
```

### Manual Installation

1. **Download the script**:
```bash
sudo nano /usr/local/bin/ptac
```

2. **Copy the ptac script content** (from the provided bash script) and save it.

3. **Make it executable**:
```bash
sudo chmod +x /usr/local/bin/ptac
```

4. **Install the manpage**:
```bash
# Create man directory if it doesn't exist
sudo mkdir -p /usr/local/share/man/man1

# Copy the manpage
sudo nano /usr/local/share/man/man1/ptac.1
```

5. **Copy the manpage content** (from the provided ptac.1 above) and save it.

6. **Update the man database**:
```bash
sudo mandb
```

### Verification

Verify your installation:
```bash
ptac --version
man ptac
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

## Documentation

### View Manpage
```bash
man ptac
```

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
export PATH="/usr/local/bin:$PATH"
```

### Manpage Not Found
```bash
# Update man database
sudo mandb

# Check manpath
man -w ptac
```

### Permission Denied
```bash
# Ensure executable permissions
sudo chmod +x /usr/local/bin/ptac
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

