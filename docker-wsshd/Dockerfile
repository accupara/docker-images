FROM alpine:3.7
RUN apk add --no-cache curl bash \
    && curl https://i.jpillora.com/chisel! | bash
ENV PORT 2222
EXPOSE 2222
ENTRYPOINT ["/usr/local/bin/chisel"]
CMD ["server", "-p", "2222"]
