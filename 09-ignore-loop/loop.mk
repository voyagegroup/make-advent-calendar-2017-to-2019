SITES=example.com voyagegroup.com voyagegroup.jp

ping:
	for v in $(SITES); do ping -c 1 $$v; done
