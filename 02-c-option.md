# -C オプション

`make -C <dir>` とすることで、指定したディレクトリでmakeコマンドを実行した状態になります。

試しに `make -C 02-c-option hello` を実行してみると、

```
echo hello!
hello!
pwd
/Users/katzchang/dev/make-advent-calendar-2017/02-c-option
```

みたいな感じになります。指定したディレクトリがカレントディレクトリになるので、つまり `cd 02-c-option && make hello` したときと同じです。

Makefileがいっぱいあるときに便利！
