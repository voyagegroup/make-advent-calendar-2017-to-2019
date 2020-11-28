
# Ignore Loop

たとえば、いくつかの要素に対して同じことをしたいとき、シェルスクリプトではforループを使って

```shellscript
SITES="example.com voyagegroup.com voyagegroup.jp"

for v in $SITES
do
  ping -c 1 $v
done
```

こんな感じにしそうです。

これをそのまま Makefile にすると

```makefile
SITES=example.com voyagegroup.com voyagegroup.jp

ping:
	for v in $(SITES); do ping -c 1 $$v; done
```

こんな感じになりがちですが、ここはもう少しかっこよくできます。つまり: 

```makefile
SITES=example.com voyagegroup.com voyagegroup.jp

all: $(SITES)

$(SITES):
	ping -c 1 $@
```

ターゲット名がしっくりこないときは、少し手間がかかるけど、名前を変えてあげても良いかもしれない。

```makefile
SITES=example.com voyagegroup.com voyagegroup.jp
ping-sites= $(patsubst %,ping-%,$(SITES))
all: $(ping-sites)

$(ping-sites):
	ping -c 1 $(patsubst ping-%,%,$@)
```

便利。
