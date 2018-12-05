
# suppress

```Makefile
run:
    echo 'hello world'
```

という Makefile を実行すると

```bash
$ make
echo 'hello world'
hello world``bash
```

となって冗長だったりする。実行コマンドの表示を抑制したくなりますよね
そんな時は、@付きにすると

```Makefile
run:
    @echo 'hello world'
```

```bash
$ make
hello world
```

便利

