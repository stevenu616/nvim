local home = os.getenv('HOME')
local workspace_path = home .."\\appdata\\local\\nvim-data\\jdtls-workspace\\"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = workspace_path .. project_name

local status, jdtls = pcall(require, 'jdtls')
if not status then
    return
end
local extendedClientCapabilities = jdtls.extendedClientCapabilities

local config = {
    cmd = {
        'java',
        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundels.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '--add-modules=ALL-SYSTEM',
        '--add-opens',
        'java.base/java.util=ALL-UNNAMED',
        '--add-opens',
        'java.base/java.lang=ALL-UNNAMED',
        '-javaagent:' .. home .. '\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\lombok.jar',
        '-jar',
        vim.fn.glob(home .. '\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\plugins\\org.eclipse.equinox.launcher_*.jar'),
        '-configuration',
        home .. '\\AppData\\Local\\nvim-data\\mason\\packages\\jdtls\\config_win',
        '-data',
        workspace_dir,
    },

    root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle', 'build.xml', 'src' },

    settings = {
        java = {
            signatureHelp = { enabled = true },
            extendedClientCapabilities = extendedClientCapabilities,
        },
        format = {
        }
    },

    init_options = {
        bundels = {}
    },
}

require('jdtls').start_or_attach(config)

vim.keymap.set('n', '<leader>jc', "<cmd>!javac %:t <cr>")
