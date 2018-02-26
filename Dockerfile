FROM centos:7.4.1708@sha256:2a61f8abd6250751c4b1dd3384a2bdd8f87e0e60d11c064b8a90e2e552fee2d7

RUN yum update -y \
 && yum install -y wget \
 && wget -qO /usr/local/bin/go-github https://github.com/qnib/go-github/releases/download/0.3.0/go-github_0.3.0_Linux \
 && chmod +x /usr/local/bin/go-github \
 && echo "# init-plain: $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo init-plain --regex 'init-plain.tar' --limit 1)" \
 && wget -qO - "$(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo init-plain --regex 'init-plain.tar' --limit 1)" |tar xf - --strip-components=1 -C / \
 && echo "# go-fisherman: $(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-fisherman --regex '.*_x86' --limit 1)" \
 && wget -qO /usr/local/bin/go-fisherman "$(/usr/local/bin/go-github rLatestUrl --ghorg qnib --ghrepo go-fisherman --regex '.*_x86' --limit 1)" \
 && chmod +x /usr/local/bin/go-fisherman \
 && echo "# gosu-amd64: $(/usr/local/bin/go-github rLatestUrl --ghorg tianon --ghrepo gosu --regex 'gosu-amd64' --limit 1)" \
 && wget -qO /usr/local/bin/gosu $(/usr/local/bin/go-github rLatestUrl --ghorg tianon --ghrepo gosu --regex 'gosu-amd64' --limit 1) \
 && chmod +x /usr/local/bin/gosu 
HEALTHCHECK --interval=5s --retries=5 --timeout=2s \
  CMD /usr/local/bin/healthcheck.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
