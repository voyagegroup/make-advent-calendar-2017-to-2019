# 依存

ターゲット の `:` の右側に、そのターゲットファイルが依存するファイルやターゲットを書くことができます。

[国民の祝日CSV](http://www.data.go.jp/data/dataset/cao_20160323_0068/resource/8290b3b2-b56d-47ec-bf22-274167936ce0)から、2018年の祝日を抜き出してみましょう。

```Makefile
YEAR := 2018

# 何もターゲットを指定しなければ syukujitsu.$(YEAR).csv を作りたい
all: syukujitsu.$(YEAR).csv

# syukujitsu.$(YEAR).csv は syukujitsu.csv に依存する
syukujitsu.$(YEAR).csv : syukujitsu.csv
	grep $(YEAR) syukujitsu.csv > syukujitsu.$(YEAR).csv

# syukujitsu.csv を取ってくる
syukujitsu.csv:
	curl -O http://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv
```

* `all` は特別なターゲット名で、ターゲットを指定しなければ `all` を実行します。
* `all` は `syukujitsu.$(YEAR).csv` に依存していますので、`syukujitsu.$(YEAR).csv` を作ろうとします。
* `syukujitsu.$(YEAR).csv` ターゲットを見ると、これは `syukujitsu.csv` に依存していますので、まずこれを作ろうとします。
* `syukujitsu.csv` ターゲットは curl で取ってくるだけのものなので、まずこれを作ります。

やってみましょう

```bash
$ make -C 06-prerequire
curl -sO http://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv
grep 2018 syukujitsu.csv > syukujitsu.2018.csv
```

makeは依存ファイルのタイムスタンプを見て、更新されたときだけ作ろうとします。もう一度同じコマンドを叩いてみましょう。

```bash
$ make -C 06-prerequire
[No write since last change]
make: Nothing to be done for `all'.
```

作りたい syukujitsu.2018.csv のタイムスタンプが依存する syukujitsu.csv よりも新しいので、やることは何もないよ、ということになります。
これは今よりもずっと計算機が遅かった頃に、無駄なコンパイルを避けて高速に開発するために必要だった機能です。今日においても便利ですね。

makeが参照しているのはタイムスタンプなので、タイムスタンプを更新してやるとまた走ります。

```bash
$ touch 06-prerequire/syukujitsu.csv
$ make -C 06-prerequire
grep 2018 syukujitsu.csv > syukujitsu.2018.csv
```

便利ですね。
