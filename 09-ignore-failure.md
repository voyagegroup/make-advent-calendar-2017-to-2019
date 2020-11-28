
# ignore failure

```Makefile
all: success failure echo

success:
    exit 0

failure:
    exit 2

echo:
    echo 'hello'
```

という Makefile があるとき、 failure ターゲットが失敗するので途中で止まってしまいます

```bash
$ make
exit 0
exit 2
make: *** [failure] Error 2
```

失敗してもスキップして継続して欲しいということがありますよね？
そんな時は

```Makefile
all: success failure echo

success:
    exit 0

failure:
    -exit 2

echo:
    echo 'hello'
```

`-` をつけてあげると、無視して継続してくれます

```bash
$ make -C 09-ignore-failure
exit 0
exit 2
make: [failure] Error 2 (ignored)
echo 'hello'
hello
```

便利。

