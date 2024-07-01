

generated_uid=$(dscl . -read $HOME GeneratedUID 2>/dev/null | awk 'NF > 1 {print $2}')

machine_uuid=$(ioreg -rd1 -c IOPlatformExpertDevice | grep -E '"IOPlatformUUID" = ' | awk '{print $3}' | tr -d '"')

derived_key=$(echo -n "${machine_uuid}-${generated-uid}" | shasum -a 256 | awk '{print $1}')

printf "%s" "$derived_key"

