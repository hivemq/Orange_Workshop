# Remove allow all extension if applicable
if [[ "${HIVEMQ_ENABLE_ESE}" != "false" ]]; then
    echo "Enabling ESE  by removing DISABLED flag in extensions/hivemq-enterprise-security-extension"
    rm /opt/hivemq/extensions/hivemq-enterprise-security-extension/DISABLED || true
fi