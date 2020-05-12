# Documentation Formatting Rules

This page describes the enforced formatting rules when authoring Hologres documenations.

## Language

Each pull request of documentation must be written at least in English.

PR in both English and Chinese would be even better.

## Menu Format

Menu structures are written in `index.rst` RST files in each directory.

For example, for a directory of section `Xxx Xxx` with 3 files, `md_file_1.md`, `md_file_2.md`, and `md_file_3.md`, the `index.rst` file should be of format as following:

``` 
##################################
<Section Title>
##################################

.. toctree::
	md_file_1
	md_file_2
	md_file_3
```

Each menu should contain all pages in its directory. If a `.md` file is not included in the `index.rst` file, you will see errors like "**WARNING: document isn't included in any toctree**".

## Documentation Format

Hologres documentation are written in `.md` markdown files.

Contributers should following standard markdown formatting with the following rules in mind.

### File and Paragraph Tiles

Title of each markdown file should use `#` as heading. 

Subtitles of sections inside should then use `##`, `###`, etc.

Tiles/subtitles should have one empty line from its content.

E.g.

```
# <File Title>
	<--empty line-->
...content...
	<--empty line-->
## Header 1
	<--empty line-->
...content...
	<--empty line-->
### Header 1.1
	<--empty line-->
...content...
	<--empty line-->
### Header 1.2
	<--empty line-->
...content...
	<--empty line-->
## Head 2
	<--empty line-->
...content...
```


### Images

Images in markdown files should be placed in the directory of `/image`, and the directory should reflect the same document structure of the markdown files. 

E.g. images of page `/doc/source/introduction/concepts.md` should be placed in directory `/doc/source/images/introduction/`.

### Tables

Markdown doesn't support tables natively. To author tables like:

| A | B |
|---|---|
| 1 | 3 |
| 2 | 4 |

you have to install the `sphinx-makrdown-tables` as mentioned in pre-requisites above, and author in the following format:

```
| A | B |
|---|---|
| 1 | 3 |
| 2 | 4 |
```

### Cross-Reference Another File

You can cross reference another markdown file in the same repository by using the absolute path in the root directory of `/source`.

E.g. say we have two files in `/doc/source/dir1/doc1.md` and `/doc/source/dir2/doc2.md`. To reference `doc1.md` in `doc2.md`, author:

```
// doc2.md
Please reference more info [here](/dir1/doc1.md).
```

### Hyperlinks

Special Attention here!

Hyperlinks will not be generated automatically in your translation. To keep the hyperlink in translated sentences, you have to put the hyperlink again in the translation.

Here's an example. Say you have hyperlink in the English page, like 

```
Click [here](http://....) to see more.
```

Then in your translation's .po file, you have to do:

```
#: ../../source/xxx/mytranslation.md:
msgid "Click here to see more."
msgstr "请到[这里](http://....)查看更多信息。"

```

### Punctuations

DO NOT forget to put the correct punctuations in your translations!

If the original sentense ends with a English period `.`, translators should end their translated sentense with a Chinese period `。`. E.g.


```
#: ../../source/xxx/mytranslation.md:
msgid "Thanks."
msgstr "谢谢。"  <- note the '。' here

```
