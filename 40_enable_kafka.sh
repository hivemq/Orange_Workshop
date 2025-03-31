if [[ "${HIVEMQ_ENABLE_KAFKA}" != "false" ]]; then
    echo "Enabling KAFKA by removing DISABLED flag in extensions/hivemq-kafka-extension"
    rm /opt/hivemq/extensions/hivemq-kafka-extension/DISABLED || true
fi