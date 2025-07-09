# Markdown to HTML Converter

A command-line tool written in Elixir that converts Markdown files to HTML.

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


### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/sijanthapa171/md2html.git
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