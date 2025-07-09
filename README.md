# Markdown to HTML Converter

A command-line tool written in Elixir that converts Markdown files to HTML.

## Features

- Converts basic Markdown syntax to HTML
- Supports headers (h1-h6)
- Supports bold and italic text
- Supports inline code and code blocks
- Supports unordered lists
- Supports blockquotes
- Supports horizontal rules
- Supports links
- Includes basic styling for the output HTML
- Built with Nix for reproducible development environment

## How to Run

### Quick Start

1. Enter the Nix development shell:
   ```bash
   nix develop
   ```

2. Compile the project:
   ```bash
   mix compile
   ```

3. Convert a Markdown file to HTML:
   ```bash
   mix md2html sample/sample.md output/sample.html
   ```

### Running Tests

Run the test suite:
```bash
mix test
```

### Example Usage

1. Convert the included sample file:
   ```bash
   mix md2html sample/sample.md
   ```
   This will create `sample.html` in the same directory.

2. Convert with a specific output path:
   ```bash
   mix md2html input.md output/result.html
   ```

3. Use in your Elixir code:
   ```elixir
   # Convert a file
   {:ok, output_path} = Md2html.convert("input.md", "output.html")

   # Convert a string directly
   html = Md2html.convert_string("# Hello World")
   ```

### Troubleshooting

If you encounter any issues:

1. Make sure you're in the Nix shell:
   ```bash
   nix develop
   ```

2. Try cleaning and recompiling:
   ```bash
   mix clean
   mix compile
   ```

3. Check file permissions:
   ```bash
   # Ensure output directory exists and is writable
   mkdir -p output
   ```

## Installation

### Prerequisites

- [Nix](https://nixos.org/download.html) package manager with flakes enabled

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/sijanthapa171/md-html.git
   cd md-html
   ```

2. Enter the development shell:
   ```bash
   nix develop
   ```

## Usage

### As a Mix Task

Convert a Markdown file to HTML:

```bash
mix md2html input.md [output.html]
```

If no output file is specified, it will use the same name as the input file with a `.html` extension.

### As a Library

```elixir
# Convert a file
Md2html.convert("input.md", "output.html")

# Convert a string
html = Md2html.convert_string("# Hello, World!")
```

## Development

1. Enter the development shell:
   ```bash
   nix develop
   ```

2. Run tests:
   ```bash
   mix test
   ```

3. Build the project:
   ```bash
   mix compile
   ```

## Project Structure

```
md2html/
├── lib/
│   ├── md2html/
│   │   ├── parser.ex        # Core Markdown parsing logic
│   │   ├── converter.ex     # HTML conversion
│   │   └── file_io.ex       # File operations
│   └── md2html.ex           # Main module
├── test/                    # Test files
├── sample/                  # Sample markdown files
└── output/                  # Generated HTML files
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

