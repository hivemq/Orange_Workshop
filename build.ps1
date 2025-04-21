$env:HIVEMQ_VERSION="4.38.0"
$env:REDPANDA_VERSION="24.2.7"
$env:REDPANDA_CONSOLE_VERSION="2.7.2"


C:\Windows\System32\curl.exe -C - -L https://releases.hivemq.com/hivemq-4.38.0.zip -o hivemq-4.38.0.zip
C:\Windows\System32\curl.exe -C - -L "https://github.com/hivemq/hivemq-prometheus-extension/releases/download/4.0.12/hivemq-prometheus-extension-4.0.12.zip" -o hivemq-prometheus-extension-4.0.12.zip

# Build the Docker image
docker build --build-arg HIVEMQ_VERSION=4.38.0 -f Dockerfile . -t hivemq/hivemq4:4.38.0
