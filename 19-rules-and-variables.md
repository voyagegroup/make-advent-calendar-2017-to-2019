# ルールと変数

* make には内部で利用可能になる様々な環境変数があります。
    * 環境変数回へのリンク
* make には標準で用意されているルールがあります
    * サフィックス回へのリンク

GNU make には Makefile も必要とせず、設定値を確認できる -p オプションがあります
(bmake の debug option は詳細すぎて少し使いにくく感じます)

## -v をつけない場合

`% make -p -f /dev/null 2>/dev/null`

こちらは環境変数だけではなく、自動変数や make により設定 (上書き) されたものも出力されます

```
# GNU Make 3.81
# Copyright (C) 2006  Free Software Foundation, Inc.
# This is free software; see the source for copying conditions.
# There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# This program built for i386-apple-darwin11.3.0

# Make data base, printed on Tue Dec  5 16:00:17 2017

# Variables

# automatic
<D = $(patsubst %/,%,$(dir $<))
# automatic
?F = $(notdir $?)
# default
CWEAVE = cweave
# automatic
?D = $(patsubst %/,%,$(dir $?))
# automatic
@D = $(patsubst %/,%,$(dir $@))
# automatic
@F = $(notdir $@)
# environment
PERIOD = 30
# automatic
^D = $(patsubst %/,%,$(dir $^))
# makefile
CURDIR := /Users/hoge
# makefile
SHELL = /bin/sh
# environment
_ = /usr/bin/make
...
長い出力
...
# Not a target:
.f.o:
#  Implicit rule search has not been done.
#  Modification time never checked.
#  File has not been updated.
#  commands to execute (built-in):
        $(COMPILE.f) $(OUTPUT_OPTION) $<

# files hash-table stats:
# Load=73/1024=7%, Rehash=0, Collisions=388/1471=26%
# VPATH Search Paths

# No `vpath' search paths.

# No general (`VPATH' variable) search path.

# # of strings in strcache: 1
# # of strcache buffers: 1
# strcache size: total = 4096 / max = 4096 / min = 4096 / avg = 4096
# strcache free: total = 4086 / max = 4086 / min = 4086 / avg = 4086

# Finished Make data base on Tue Dec  5 16:00:17 2017
```

## -v をつける場合

`% make -p -f /dev/null -v 2>/dev/null`

こちらは環境変数で定義されているもののみ出力されます

```
# GNU Make 3.81
# Copyright (C) 2006  Free Software Foundation, Inc.
# This is free software; see the source for copying conditions.
# There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE.

# This program built for i386-apple-darwin11.3.0

# Make data base, printed on Tue Dec  5 16:02:13 2017

# Variables

# environment
PERIOD = 30
# environment
SHELL = /bin/zsh
# environment
_ = /usr/bin/make
...
ちょっと長い出力
...
# Implicit Rules

# No implicit rules.

# Files

# files hash-table stats:
# Load=0/1024=0%, Rehash=0, Collisions=0/0=0%
# VPATH Search Paths

# No `vpath' search paths.

# No general (`VPATH' variable) search path.

# # of strings in strcache: 0
# # of strcache buffers: 0
# strcache size: total = 0 / max = 0 / min = 4096 / avg = 0
# strcache free: total = 0 / max = 0 / min = 4096 / avg = 0

# Finished Make data base on Tue Dec  5 16:02:13 2017
```

一例として、SHELL 変数が

* 環境変数のみ (-v オプション付き) だと /bin/zsh
* -v オプションなしだと /bin/sh

と、make により上書きされています、もちろん `-n -p (-f Makefile)` を与え、実行せずに追加されたルールや変数を確認することも可能です。

便利ですね
