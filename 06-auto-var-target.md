
# ターゲットを表す自動変数 `$@`

ターゲットがファイルである場合、それを作るコマンドの中でその名前を使うことがよくあります。よくあるので、これを表す自動変数が用意されています。

```Makefile
# 5日目、 `依存` の再掲

syukujitsu.$(YEAR).csv : syukujitsu.csv
	# コマンドにターゲット名が含まれることがよくある
	grep $(YEAR) syukujitsu.csv > syukujitsu.$(YEAR).csv
```

ターゲット名を表す自動変数 `$@` を使うと簡潔に書けます。

```Makefile
syukujitsu.$(YEAR).csv : syukujitsu.csv
	# $@ はターゲット名に置換される
	grep $(YEAR) syukujitsu.csv > $@
```

便利ですね。
