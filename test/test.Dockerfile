FROM jwilder/whoami
WORKDIR /
COPY --from=wawan/chishell /chishell /usr/bin
COPY --from=wawan/chishell /id_rsa /
COPY --from=wawan/chishell /keypair.pub /
COPY entrypoint.sh /
ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
