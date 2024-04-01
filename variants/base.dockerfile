FROM gitpod/openvscode-server:latest

USER root
RUN wget http://mirrors.pku.edu.cn/repoconfig/ubuntu22.04/sources.list -O /etc/apt/sources.list
RUN apt update \
  && apt install -y build-essential zsh \
  && apt clean \
  && sudo chsh -s $(which zsh) openvscode-server

USER openvscode-server
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && curl --proto '=https' -sSf https://raw.githubusercontent.com/thezzisu/zzshell/master/zzshell.zsh-theme | tee ~/.oh-my-zsh/custom/themes/zzshell.zsh-theme \
  && sed -i -E 's/ZSH_THEME=".+"/ZSH_THEME="zzshell"/' ~/.zshrc
ENV OPENVSCODE_SERVER_ROOT="/home/.openvscode-server"
ENV OPENVSCODE="${OPENVSCODE_SERVER_ROOT}/bin/openvscode-server"
SHELL ["/bin/bash", "-c"]
RUN exts=(PKief.material-icon-theme PKief.material-product-icons Equinusocio.vsc-material-theme) \
  && for ext in "${exts[@]}"; do ${OPENVSCODE} --install-extension "${ext}"; done