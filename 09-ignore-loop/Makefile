SITES=example.com voyagegroup.com voyagegroup.jp

all: all1 all2

## simple
all1: $(SITES)

$(SITES):
	ping -c 1 $@


## prefixed
ping-sites= $(patsubst %,ping-%,$(SITES))
all2: $(ping-sites)

$(ping-sites):
	ping -c 1 $(patsubst ping-%,%,$@)
