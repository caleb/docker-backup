#!/usr/bin/env bash
set -e
shopt -s globstar nullglob

. /helpers/links.sh

read_link SMTP smtp 25 tcp

# Determine the smtp server's fingerprint
if [ -n "${SMTP_ADDR}" ]; then
  info="$(msmtp --serverinfo --tls --tls-certcheck=off --host="${SMTP_ADDR}")"
  if [[ "${info}" =~ SHA1:[[:space:]](([0-9A-Fa-f]{2}:?){20})  ]]; then
    export SMTP_FINGERPRINT="${BASH_REMATCH[1]}"
  fi
fi

# Create the backup cron job
cat > /etc/cron.d/date <<EOF
*   *   *   *   *   date >> /tmp/dates.txt
*   *   *   *   *   date
EOF

declare -a templates=(/etc/msmtprc.mo)

# Fill out the templates
for f in "${templates[@]}"; do
  /usr/local/bin/mo "${f}" > "${f%.mo}"
  rm "${f}"
done

exec "${@}"
