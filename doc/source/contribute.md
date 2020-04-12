# Contribute

There are many ways to contribute to Hologres community.

## Contribute to Code


## Contribute to Documentation 

### Build Documentation Locally

#### Step 1: Install Sphinx

For a quickstart with Sphinx and ReadTheDoc, please check out [here](https://docs.readthedocs.io/en/stable/intro/getting-started-with-sphinx.html).

To build the documentation website locally, you need to first install Sphinx and several extensions we use.

```
$ pip install sphinx --upgrade 				# sphinx itself
$ pip install recommonmark --upgrade 		# entension to use Markdown in Sphinx
$ pip install sphinx_rtd_theme --upgrade 	# the Sphinx theme we use
$ pip install sphinx-intl 					# the internationalization extension
```

#### Step 2: Generate HTMLs

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

#### Step 3: Check the website

Open `/build/html/index.html` with your browser, and you should be able to see the newly generated documentation website locally. 


### Develop and Modify Documentations

#### Step 1: Develop and Modify Markdown Files

Develop and modify Markdown Files as you wish. 

All original files should be written in English.

All content should following the requirements stated in "Formatting Rules" below.

#### Step 2: Generate Localization Files

Hologres documentation right now supports both English and Chinese. (More localizations and languages are welcome!)

To understand how Sphinx and sphinx-intel tranlation flow works, [read this guide](http://www.sphinx-doc.org/en/master/usage/advanced/intl.html#translating-with-sphinx-intl).

Each commit should make sure the English and Chinese documentations are in sync. 

Once you have finished modifying the markdown files in English, it's time to finish the Chinese counterpart.

First, extract translatable messages into pot files, and generate the po files for Chinese translation:

```
$ make gettext									# Extract translatable messages into pot files
$ sphinx-intl update -p build/gettext -l zh	# Generate po files
```

Once completed, the generated po files will be placed in the `/locale/zh/LC_MESSAGES` directory.

Note! For deleted or renamed Markdown files, their corresponding original .po files may not be automatically deleted, you need to manually delete them.

#### Step 3: Translate .po Files

AS noted above, these are located in the ./locale/<lang>/LC_MESSAGES directory.

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

#### Step 4: Build Translated Document

You need a [language](http://www.sphinx-doc.org/en/master/usage/configuration.html#confval-language) parameter in conf.py to build documents for a specific language. By default, it's English (en). 

The easiet to build Chinese documents is to specify the parameter on the build command line.

For for BSD/GNU make, run:

```
$ make -e SPHINXOPTS="-D language='zh'" html
```

Open `/build/html/index.html` with your browser, and you should be able to see the newly generated documentation website locally. 

### Deploy

Once any changes are committed in github, github will notify readthedoc via webhook, and trigger build process. If it builds successfully, documentations will automatically be deployed; otherwise, it fails and waits to be fixed.

The build page can be found [here](https://readthedocs.org/projects/hologres/).


### Formatting Rules



### Committing Rules

Each commit 

- must be submitted in a Pull Request (PR) first, reviewed by a community trusted member, then merge via the PR. No commit can be pushed to repository directly by the ones who have commit priviledge.

- must have both the English and Chinese changes to keep our multi-language documentations in sync.

The only exception is for initial documentation migration commits.


### Theme

We use ReadTheDoc's native theme, sphinx_rtd_theme.

Installation and configuration of the theme can be found [here](https://sphinx-rtd-theme.readthedocs.io/en/stable/).