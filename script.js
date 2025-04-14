function convert(fahrenheit) {
    return Math.floor((fahrenheit - 32) * 5/9);
}

function transform(publish, context) {
    publish.payload = {
        "celsius": convert(publish.payload.fahrenheit),
        "timestamp": publish.payload.timestamp
    }
    return publish;
}

