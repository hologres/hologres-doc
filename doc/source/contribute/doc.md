# Contribute to and Deploy Documentation 

## Pre-requisite: Fork the repository and downdload

Forking [the Github repository](https://github.com/hologres/hologres-doc.git), and downdloading your forked repo locally are the required pre-requisites to get started with any efforts below.

Please find the following Github instructions on how to fork a repository, how to configure the remote upstream branch for the forked one, and how to sync a fork.

- [fork a repo](https://help.github.com/en/github/getting-started-with-github/fork-a-repo)
- [configure a remote for a fork](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/configuring-a-remote-for-a-fork)
- [sync a fort](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/syncing-a-fork)

## Build Documentation Locally

### Step 1: Install Sphinx

For a quickstart with Sphinx and ReadTheDoc, please check out [here](https://docs.readthedocs.io/en/stable/intro/getting-started-with-sphinx.html).

To build the documentation website locally, you need to first install Sphinx and several extensions we use.

```
$ pip install sphinx                        # sphinx itself
$ pip install recommonmark                  # entension to use Markdown in Sphinx
$ pip install sphinx_rtd_theme              # the Sphinx theme we use
$ pip install sphinx-intl                   # the internationalization extension
$ pip install sphinx-markdown-tables        # the extension to support table syntax in markdown files
```

### Step 2: Generate HTMLs

First, fork and clone the hologres-doc repository to your computer. Go to the `/docs` directory and generate HTMLs with:

```
$ cd docs
$ make html
```

HTMLs generated are located in `/build` directory, and should never be checked into source code.

To clean up any existing HTMLs cached in `/build` directory, run: 

```
$ make clean
```

### Step 3: Check the website

Open `/build/html/index.html` with your browser, and you should be able to see the newly generated documentation website locally. 


## Develop and Modify Documentations

### Step 1: Develop and Modify Markdown Files

Develop and modify Markdown Files as you wish. 

All original files should be written in English.

All content should following the requirements stated in "Formatting Rules" below.

### Step 2: Generate Localization Files

Hologres documentation right now supports both English and Chinese. (More localizations and languages are welcome!)

To understand how Sphinx and sphinx-intel tranlation flow works, [read this guide](http://www.sphinx-doc.org/en/master/usage/advanced/intl.html#translating-with-sphinx-intl).

Each commit should make sure the English and Chinese documentations are in sync. 

Once you have finished modifying the markdown files in English, it's time to finish the Chinese counterpart.

First, extract translatable messages into pot files, and generate the po files for Chinese translation:

```
$ make clean		# clean the cached build files
$ make gettext	# Extract translatable messages into pot files
$ sphinx-intl update -p build/gettext -l zh		# Generate po files
```

Once completed, the generated po files will be placed in the `/locale/zh/LC_MESSAGES` directory.

Note! For deleted or renamed Markdown files, their corresponding original .po files may not be automatically deleted, you need to manually delete them.

### Step 3: Translate .po Files

As noted above, these are located in the `./locale/<lang>/LC_MESSAGES` directory.

An example of one such file, from Sphinx, builders.po, is given below.

```
#: ../../source/product/hologres.md:3
msgid ""
"Hologres is a real-time interactive analysis data warehouse, providing "
"enterprises with online analytics service with high availability and low "
"latency. It is fully compatible with PostgreSQL 11 and seamless connected"
" with big data ecosystem."
msgstr "交互式分析（Hologres）是一款全面兼容PostgreSQL 11协议并与大数据生态"
"无缝打通的实时交互式分析产品，为企业提供高可用低延时的海量数据在线查询分析服务。"
```

### Step 4: Build Translated Document

You need a [language](http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-language) parameter in conf.py to build documents for a specific language. By default, it's English (en). 

The easiet to build Chinese documents is to specify the parameter on the build command line.

For for BSD/GNU make, run:

```
$ make -e SPHINXOPTS="-D language='zh'" html
```

Open `/build/html/index.html` with your browser, and you should be able to see the newly generated documentation website locally. 

### Step 5: Submit Pull Requests

Submit Pull Requests to the original repository (from which you forked) by following [Github instructions here](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).

## Deploy

Once any changes are committed in Github, Github will notify readthedoc via webhook, and trigger build process. If it builds successfully, documentations will automatically be deployed; otherwise, it fails and waits to be fixed.

The build page can be found [here](https://readthedocs.org/projects/hologres/).

## Theme

We use ReadTheDoc's native theme, `sphinx_rtd_theme`.

Installation and configuration of the theme can be found [here](https://sphinx-rtd-theme.readthedocs.io/en/stable/).