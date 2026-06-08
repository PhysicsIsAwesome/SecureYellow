set -euo pipefail
kver=$(basename $(find /target/usr/lib/modules -maxdepth 1 -mindepth 1 -type d -print0))
cmdline="\"$1\""
ukify_args="\
            --secureboot-private-key /run/secrets/secureboot_key \
            --secureboot-certificate /run/secrets/secureboot_cert \
            --measure \
            --output /boot/${kver}.efi"
bootc container ukify --rootfs /target --karg "${cmdline}" -- ${ukify_args}