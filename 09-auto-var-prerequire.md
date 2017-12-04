
# 依存物を表す自動変数 $^

ターゲット名を表す `$@` と同様に、依存物を表す変数 `$^` もあります。

```Makefile
syukujitsu.$(YEAR).csv : syukujitsu.csv
	# `$^` は依存物に置換される
	grep $(YEAR) $^ > $@
```

便利ですね。
