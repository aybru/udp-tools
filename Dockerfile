FROM alpine AS builder
RUN apk add --no-cache git build-base linux-headers
ADD . /
RUN set -x \
&& cd /module/udp2raw && make dynamic && mv udp2raw_dynamic /rootfs/bin/udp2raw \
&& cd /module/UDPspeeder && make && mv speederv2 /rootfs/bin/speederv2

FROM alpine
RUN apk add --no-cache libstdc++ iptables
COPY --from=builder /rootfs /

ENTRYPOINT ["entrypoint"]
