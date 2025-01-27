FROM alpine:latest

RUN apk add git neovim gcc musl-dev make curl wget unzip gzip python3 bash npm go ripgrep
RUN git clone https://github.com/fernandoflorez/nv ~/.config/nvim

WORKDIR /projects

CMD  ["/bin/bash"]
