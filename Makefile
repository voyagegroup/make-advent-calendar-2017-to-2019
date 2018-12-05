.PHONY: all build gen clean

all: clean gen

DOCKER_IMAGE := hugo

build: Dockerfile
		docker build -t $(DOCKER_IMAGE) .

gen: themes/techdoc build $(addprefix content/posts/,$(filter-out README.md,$(wildcard *.md)))
		docker run \
		    --rm \
		    --name hugo \
		    -v $(CURDIR):/work \
		    -w /work \
		    $(DOCKER_IMAGE) -D

clean:
		rm -rf content themes docs resources

content content/posts:
		mkdir -p $@

content/_index.md: README.md content
		cp $< $@

content/posts/%.md: %.md content/_index.md content/posts
		echo '---' > $@
		echo 'title: "$(subst -, ,$*)"' >> $@
		echo "date: $$(date --iso-8601=seconds --date "$$(echo $* | awk -F- '{print $$1}') seconds ago")" >> $@
		echo 'draft: false' >> $@
		echo '---' >> $@
		cat $< >> $@
		sed -i -e 's;$<;posts/$*/;g' content/_index.md

themes/techdoc:
		git clone --depth=1 https://github.com/thingsym/hugo-theme-techdoc.git $@
