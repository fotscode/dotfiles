local DEFAULT_FQBN = "esp32:esp32:esp32"
return {
    cmd = {
        "arduino-language-server",
        "-cli-config", "/home/fots/.arduino15/arduino-cli.yaml",
        "-fqbn",
        DEFAULT_FQBN,
    },
}
