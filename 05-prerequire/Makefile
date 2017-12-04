YEAR := 2018

# syukujitsu.$(YEAR).csv を作りたい
all: syukujitsu.$(YEAR).csv

# syukujitsu.$(YEAR).csv は syukujitsu.csv に依存する
syukujitsu.$(YEAR).csv : syukujitsu.csv
	grep $(YEAR) syukujitsu.csv > syukujitsu.$(YEAR).csv

# syukujitsu.csv を取ってくる
syukujitsu.csv:
	curl -sO http://www8.cao.go.jp/chosei/shukujitsu/syukujitsu.csv

clean:
	rm *.csv
