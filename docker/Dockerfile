
# the default YaST image to use
ARG image=registry.opensuse.org/yast/head/containers/yast-ruby:latest

FROM ${image}

ENTRYPOINT [ "rake", "run[widget_demo]" ]

# install X11
RUN zypper --non-interactive install --no-recommends \
  -t pattern x11

# install the YaST graphical frontend + theme (with font dependencies, etc...)
RUN zypper --non-interactive install --no-recommends \
  libyui-qt \
  yast2-theme
