FROM debian:buster-slim

RUN set -x \
		&& apt-get update \
		&& apt-get -y install curl ca-certificates

ARG HUGO_VERSION="0.52"
RUN set -x \
		&& cd /tmp \
		&& curl -sSL -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
		&& tar xf hugo.tar.gz \
		&& mv hugo /usr/local/bin/hugo \
		&& chmod +x /usr/local/bin/hugo \
		&& rm -f hugo.tar.gz /tmp/*

ENTRYPOINT ["/usr/local/bin/hugo"]
CMD ["--help"]

