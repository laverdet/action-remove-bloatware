#!/bin/bash
set -eu
df -h /
echo "::group::cleanup"
EXTRA_APT=()
EXTRA_FS=()
if [[ "$INPUT_LANG" != dotnet ]]; then
  EXTRA_APT+=('^dotnet-.*')
elif [[ "$INPUT_LANG"  != java ]]; then
  EXTRA_APT+=('^temurin.+')
elif [[ "$INPUT_LANG" != rust ]]; then
  EXTRA_FS+=(/etc/skel/.rustup) #487mb
fi
if [[ "$INPUT_DOCKER" != true ]]; then
  docker system prune -af
  EXTRA_APT+=(containerd.io)
fi
sudo apt-get remove \
  "${EXTRA_APT[@]}" \
  '^php.*' \
  azure-cli \
  buildah \
  google-chrome-stable \
  google-cloud-cli \
  kubectl \
  microsoft-edge-stable \
;
sudo rm -rf \
  "${EXTRA_FS[@]}" \
  /opt/hostedtoolcache/CodeQL `#5.0gb` \
  /usr/local/.ghcup `#5.5gb` \
  /usr/local/aws-cli `#226mb` \
  /usr/local/aws-sam-cli `#167mb` \
  /usr/local/bin/minikube `#92mb` \
  /usr/local/bin/oc `# 155mb` \
  /usr/local/bin/pulumi* `#362mb` \
  /usr/local/bin/terraform `#85mb` \
  /usr/local/julia-* `#601mb` \
  /usr/local/lib/android `#7.6gb` \
  /usr/local/share/chromium `#530mb` \
  /usr/local/sqlpackage `#112mb` \
;
echo "::endgroup::"
df -h /
