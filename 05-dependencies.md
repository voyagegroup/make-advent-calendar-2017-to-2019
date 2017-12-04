# 依存

ターゲットには、依存するターゲットを書くことができます。ここでは例として、json apiを叩いて結果を整形してみるみたいなことをやってみます。

"https://api.github.com/users/katzchang/orgs" のようなアドレスを叩くと、そのユーザが所属するorgの情報が返ってくるらしいので、そこからloginという項目を列挙してみます。apiアクセスの結果を `katzchang.json` という一時ファイルに保存して、そいつをjqしてやりましょう。

```Makefile
logins: katzchang.json
	jq -r ".[].login" katzchang.json

katzhang.json:
	curl "https://api.github.com/users/katzchang/orgs" > katzchang.json

clean:
	rm -f katzchang.json
```

`logins: katzchang.json` などと記述することで、 `katzchang.json` ファイルがない場合にはそいつを実行させることができます。作り方は `katzchang:json:` 以下に書いてあるとおり。

実行してみましょう。

```
$ make -C 05-dependencies
curl "https://api.github.com/users/katzchang/orgs" > katzchang.json
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  2499  100  2499    0     0   2465      0  0:00:01  0:00:01 --:--:--  2466
jq -r ".[].login" katzchang.json
VG-Tech-Dojo
zucks
tddbc
voyagegroup
```

下の4行が求める結果になっていそうです。やったね！

## おまけ

続けてもう一回実行してみます。

```
$ make
jq -r ".[].login" katzchang.json
VG-Tech-Dojo
zucks
tddbc
voyagegroup
```

今回は `katzchang.json` ファイルがすでに存在するので、実行がスキップされています。時間のかかる処理などが何度も実行されないようになってそうです。
