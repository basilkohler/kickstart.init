local java_home = '/Users/basil/Library/Java/JavaVirtualMachines/openjdk-18.0.1.1/Contents/Home'
local java_bin = java_home .. '/bin/java'
local jdtls_home = '/opt/homebrew/opt/jdtls'
local jdtls_install = jdtls_home .. '/libexec'
-- ls /opt/homebrew/opt/jdtls/libexec/plugins | grep org.eclipse.equinox.launcher_
local version_number = '1.6.500.v20230717-2134'
local system = 'mac' -- `linux`, `win` or `mac`

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = '~/.cache/jdtls/workspace/' .. project_name


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- 💀 -> modified
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    java_bin,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', jdtls_install .. '/plugins/org.eclipse.equinox.launcher_' .. version_number .. '.jar',

    -- 💀
    '-configuration', jdtls_install .. '/config_' .. system,

    -- 💀
    '-data', workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
