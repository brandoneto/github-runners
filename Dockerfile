FROM archlinux:latest

RUN pacman -Sy texlive-core texlive-formatsextra texlive-latexextra texlive-fontsextra --noconfirm

RUN mkdir runner && mkdir runnertmp

WORKDIR /runnertmp

RUN curl -o actions-runner-linux-x64-2.296.2.tar.gz -L https://github.com/actions/runner/releases/download/v2.296.2/actions-runner-linux-x64-2.296.2.tar.gz && tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz && rm ./actions-runner-linux-x64-2.296.2.tar.gz

RUN rm -r /var/cache/pacman/pkg/*

COPY entrypoint.sh /usr/bin/

RUN chown 1001:121 /usr/bin/entrypoint.sh && chmod +x /usr/bin/entrypoint.sh

USER 1001

ENTRYPOINT ["/usr/bin/bash", "-c", "/usr/bin/entrypoint.sh"]