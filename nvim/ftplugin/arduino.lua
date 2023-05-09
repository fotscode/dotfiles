local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    A = {
        name = "Arduino",
        c = { "<Cmd>terminal arduino-cli compile --fqbn esp32:esp32:esp32 %:h<CR>", "Compile" },
        u = { "<Cmd>terminal arduino-cli upload -p /dev/ttyUSB0 --fqbn esp32:esp32:esp32 %:h<CR>", "Upload" },
        m = { "<Cmd>terminal arduino-cli monitor -p /dev/ttyUSB0 -c baudrate=$(cat % | grep 'Serial.begin' | sed 's/[^0-9]*//g')<CR>i", "Monitor" },
        f = { "<Cmd>terminal arduino-cli compile --fqbn esp32:esp32:esp32 %:h && arduino-cli upload -p /dev/ttyUSB0 --fqbn esp32:esp32:esp32 %:h && arduino-cli monitor -p /dev/ttyUSB0 -c baudrate=$(cat % | grep 'Serial.begin' | sed 's/[^0-9]*//g')<CR>i", "Compile, Upload and Monitor" },
    },
}

which_key.register(mappings, opts)
