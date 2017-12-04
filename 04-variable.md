
# 変数

Makefile 内で変数を使うことができます。

```Makefile
ENV := production

all:
	echo $(ENV)
```

```bash
$ make -C 04-variable
echo production
production
```

変数の値を実行時に上書きしていすることもできます。便利ですね。

```bash
$ make ENV=develop -C 04-variable
echo develop
develop
```
