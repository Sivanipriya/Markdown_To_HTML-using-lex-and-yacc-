# Markdown to HTML Converter using Lex and Yacc

This project implements a **Markdown to HTML** converter using **Lex** and **Yacc**. It processes a simple Markdown file, converting various Markdown elements (such as headers, bold text, anchors, and inline CSS) into corresponding HTML code.

The project is implemented in **C**, and it utilizes **Lex** for lexical analysis and **Yacc** for parsing and code generation. The converter is capable of handling different Markdown elements and also embedding **CSS styles** directly within the HTML output.

## Features

- **Markdown Parsing**: Converts basic Markdown elements to HTML:
  - Headers (`#`, `##`, etc.)
  - Bold text (`**bold**`)
  - Anchor links (`[text](link)`)
  - Images (`![alt](url)`)
  - Paragraphs (`Some text` in a new line)
- **Inline CSS Styling**: Supports the embedding of CSS styles within the HTML output.
- **Memory Management**: Uses dynamic memory allocation to build the HTML content on-the-fly.
  
## Lex and Yacc Breakdown

### Lex: Tokenization
Lex is used for recognizing the different Markdown elements (such as headers, bold tags, and links) by breaking down the input text into tokens.

### Yacc: Parsing and HTML Generation
Yacc processes the tokens produced by Lex and generates the corresponding HTML output. It supports the following Markdown-to-HTML transformations:
1. **Headers**: Converts Markdown headers (`#`, `##`, etc.) into `<h1>`, `<h2>`, etc., tags.
2. **Bold Text**: Converts bold text (using `**`) into `<strong>` tags.
3. **Anchor Tags**: Converts anchor links (formatted as `[text](link)`) into HTML `<a>` tags.
4. **Embedded CSS**: Allows users to embed custom CSS within `<style>` tags.

### Example of Markdown to HTML Conversion

**Input Markdown:**
```markdown
# Heading 1 { . class }
Some paragraph text.
**Bold text**
[Link](http://example.com) { # id }
![Image](http://example.com/image.png)

<style>
.class { color: blue; }
# id { color:red; }
</style>
