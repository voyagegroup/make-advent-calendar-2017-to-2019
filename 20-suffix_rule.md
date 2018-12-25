
# サフィックスルール

## 本来の使い方

拡張子を元に、ファイルの作り方を記述する機能です。
一般的なC処理系では、1つのソースコード(.c拡張子)をコンパイルしてオブジェクトファイル(.o拡張子)を作ります。
もちろん以下のようにすべてのソースコードについてルールを書いていってもいいのですが、DRYにしたいものです。

```Makefile
hoge.o : hoge.c
    $(CC) -c $< -o $@

fuga.o : fuga.c
    $(CC) -c $< -o $@

# あと243個並ぶ
```

拡張子のみが違って、拡張子以外のファイル名が同じであるならば、サフィックスルールを使って共通化することができます。

```Makefile
%.o : %.c
    $(CC) -c $< -o $@
```

## 面白おかしい使い方

昨今ですと、拡張子を元に作り方が決まるという例はそう多くありません。
ですが、拡張子というのはなんなら勝手に使ってもいいので、うまく活用すると面白おかしい Makefile を書くことにより強力な記述をすることができます。

例として、ローカルにある圧縮されたログファイルをGoogle Cloud Strageにアップロードしてから、BigQuery にロードさせるような仕事を考えましょう。embulkのようなツールを使ってももちろんいいですが、雑にやるなら gsutil や bq コマンドを使って手軽に実現してやることもできます。

`YYYY/MM/DD/HHmm.json.gz` のような行分割JSON形式のログがたくさんあるとしましょう。
それぞれ5分間のログを圧縮したものです。これをBigQueryに5分間分のテーブルとしてロードさせます。
`$(PROJECT)` `$(DATASET)` `$(BQ_LOAD_OPTION)` `$(SCHEMA_FILE)` などのマクロは必要なものが設定されているとします。

```Makefile

# ファイル名をテーブル名にsedで変換
TABLE_5MIN = $(shell echo $* | sed -e 's/\./_/g')

# gcsにアップ済みのものをBQにロードする
%.gz.bql : %.gz.gcs
    bq rm -f $(PROJECT):$(DATASET).$(TABLE_5MIN)
    bq mk    $(PROJECT):$(DATASET).$(TABLE_5MIN)
    bq --project_id=$(PROJECT) load $(BQ_LOAD_OPTION) \
        $(DATASET).$(TABLE_5MIN) $(GS_BUCKET)/$*.gz `cat $(SCHEMA_FILE)`
    bq --project_id=$(PROJECT) show $(DATASET).$(TABLE_5MIN) > $@G


# .gz ファイルをGCSにアップする。.gcsファイルはとりあえずアップ後のstat結果を書いておく
%.gz.gcs : %.gz
    gsutil -m cp $< $(GS_BUCKET)/$<
    gsutil stat $(GS_BUCKET)/$< > $@
```
