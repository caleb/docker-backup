account default

{{#SMTP_ADDR}}
host {{SMTP_ADDR}}
{{#SMTP_ADDR}}

{{#SMTP_PORT}}
port {{SMTP_PORT}}
{{#SMTP_PORT}}

{{#SMTP_FINGERPRINT}}
tls on
tls_fingerprint {{SMTP_FINGERPRINT}}
{{/SMTP_FINGERPRINT}}

{{#BACKUP_FROM_ADDRESS}}
from {{BACKUP_FROM_ADDRESS}}
{{/BACKUP_FROM_ADDRESS}}

{{#SMTP_USER}}
{{#SMTP_PASSWORD}}
user {{SMTP_USER}}
password {{SMTP_PASSWORD}}
auth on
{{/SMTP_PASSWORD}}
{{/SMTP_PASSWORD}}
