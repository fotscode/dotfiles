local DEFAULT_FQBN = "esp32:esp32:esp32"
local HOME= os.getenv("HOME")
return {
    cmd = {
        "arduino-language-server",
        "-cli-config", HOME.."/.arduino15/arduino-cli.yaml",
        "-fqbn",
        DEFAULT_FQBN,
    },
}
