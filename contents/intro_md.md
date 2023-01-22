---
title: "Introduction to Markdown"
author: "Jacob Høigilt"
date: January 17 2023
fontfamily: utopia
theme: Warsaw
fontsize: 10pt
---

# Introductory remark
This is a very short introduction to the basics of Markdown. It is written in the simplest way possible, so this html page is basic and quite ugly, but it works. The markdown file used to produce this web page will work equally well in .pdf and .docx/.odt formats. The markdown file is found [here]()
\
\
\

# What is Markdown?

It is a plain text format with some simple codes that tell various software how to display characters. For example, asterisks before and after a word will tell the software to display the text in italics, like this: `*italics here*`, which will shpw up like this: 

*italics here*. 

There are numerous guides and cheat sheets for Markdown on the web, so it's easy to get help if you cannot remember the codes for simple formatting. Here's three:

[Markdownguide](https://www.markdownguide.org/getting-started)

[HowtoGeek's guide, focus on web pages](https://www.howtogeek.com/448323/what-is-markdown-and-how-do-you-use-it/)

[Markdown Tutorial, live web-based tutorial](https://www.markdowntutorial.com/)

\
\
\

# Why Markdown?
- Can be read by all devices and systems without problems or garbled text. You are not bound to any specific software and your text can be read flawlessly forever.
- Is extremely versatile. I can display this document equally well as a web page, a docx document, a slideshow and a pdf file. 
- It lets you focus on the content of your text, leaving the question of fancy formatting options (like in Word) for later.
- It gives you full control over your text - at all times you understand what's going on. But there's a price to be paid: it requires learning.
\
\
\

# The components of an .md file

# The YAML header

The header contains metadata about your text, some of which will be shown in the output. It is written in a separate language called YAML, which you can read more about here: [Quire page on YAML and Markdown](https://quire.getty.edu/docs-v1/fundamentals/)

Here is the YAML header I used for this document:

```markdown
---
title: Introduction to Markdown
author: Jacob Høigilt
date: today
fontfamily: utopia
---
```

The YAML header can contain a lot of different elements for various file types, but these are the most essential ones that you will probably always want to include. It is very important that you write the YAML field exactly as shown here. YAML is case sensitive and also sensitive to indentations, and just one empty space too many will give you an error. 

Try this out. Open an empty file in your text editor of choice and write a YAML header. Next, we will write some Markdown in the same file.
\
\
\

# The actual Markdown text

If you don't want any specific formatting, you just write like you normally would. But as shown above, you can code for italics. You can also code for bold, underline, simple tables, etc., like this:
\
\

| Markdown text | Output |
| -----------   | ----------- |
| `**Bold**` | **Bold** |
| `1. numbered lists` | 1. numbered lists |
| `2. numbered lists` | 2. numbered lists |

\
\
And here's the source code for the table above:
\


```

| Markdown text | Output |
| -----------   | ----------- |
| `**Bold**` | **Bold** |
| `1. numbered lists` | 1. numbered lists |
| `2. numbered lists` | 2. numbered lists |

```
\
To tell a web browser that you want a line break in your text, you use this character `\`. I have inserted three `\` under each other to create the space between this and the next paragraph.
\
\ 
\

# Inserting hyperlinks and images
I want to insert a hyperlink to [A Plain Text Workflow for Academic Writing with Atom](http://u.arizona.edu/~selisker/post/workflow/)

This is one example of a plaintext workflow. Note that Atom is no longer being supported by developers, so it's better to use another editor, such as VSCode or VSCodium for or Notepad++.

Here's an image.

There are options in Markdown for placing the image on a page, but I won't go into it here. Explore on your own and share! For simplicity's sake, you should place the image file in the same directory/folder as your Markdown document, so you won't have to specify the file path.

![uio screenshot](uio_screenshot.png)
