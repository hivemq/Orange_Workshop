if [[ "${HIVEMQ_ENABLE_POSTGRES}" != "false" ]]; then
    echo "Enabling KAFKA by removing DISABLED flag in extensions/hivemq-postgresql-extension"
    rm /opt/hivemq/extensions/hivemq-postgresql-extension/DISABLED || true
fi