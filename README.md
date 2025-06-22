# My Neovim Configuration

---
![Captura de pantalla de mi configuración de Neovim](https://pbs.twimg.com/media/GuEJAjrXIAAti1G?format=jpg&name=medium)

---

## 🏗️ Basic Structure

The organization of Neovim configuration files is crucial for maintainability and modularity. Here's the core structure:

* **`.` (Root Directory)**
    * `after/plugin/`: Contains **plugin-specific configurations** (`.lua` files) that load at the very end.
    * `init.lua`: The **main entry point** for Neovim.
    * `lua/fabri/`: My **personal directory** for core configuration.
        * `init.lua`: The **main orchestrator** that loads other configuration modules.
        * `set.lua`: Defines **basic Neovim options** (`vim.opt`).
        * `remap.lua`: Where **global keymaps** (keyboard shortcuts) are defined.
        * `lazy.lua`: Manages and declares my **plugins using Lazy.nvim**.
    * `lazy-lock.json`: An **automatically generated file** by Lazy.nvim to lock plugin versions.

---

## 🔄 Loading Flow

Neovim configuration loads in a specific, logical sequence:

1.  **`init.lua`**: This is the first file Neovim reads. Its primary task is to load my main orchestrator: `lua/fabri/init.lua`.
2.  **`fabri/init.lua`**: Once loaded, this file sequentially executes the following modules:
    ```lua
    require('fabri.set')    -- First, basic editor options are set.
    require('fabri.remap')  -- Then, your custom keyboard shortcuts are defined.
    require('fabri.lazy')   -- Finally, Lazy.nvim is initialized and your plugins are loaded.
    ```
3.  **Lazy.nvim**: Takes over to install (if needed), update, and load all plugins I've declared in `lua/fabri/lazy.lua`.
4.  **Post-Initialization (`after/plugin/`)**: After Neovim and Lazy.nvim have finished loading everything else, any `.lua` file found in the `after/plugin/` directory is automatically loaded. This is perfect for plugin configurations that require the plugin to be fully initialized before their settings can be applied.

---

## ✏️ Where to Make Changes

Knowing exactly where to modify each aspect of this configuration is key to keeping it organized. Use this table as a guide:

| What you want to modify         | File                          | Example Syntax                                        | Purpose                                                      |
|:--------------------------------|:------------------------------|:------------------------------------------------------|:-------------------------------------------------------------|
| **General Neovim options** | `lua/fabri/set.lua`           | `vim.opt.tabstop = 4`                                 | Adjust editor settings like indentation, line numbers, etc.  |
| **Global keyboard shortcuts** | `lua/fabri/remap.lua`         | `vim.keymap.set('n', '<leader>o', '<cmd>Oil<CR>')`   | Create your own custom shortcuts for commands or functions.  |
| **Add/remove plugins** | `lua/fabri/lazy.lua`          | `{'stevearc/oil.nvim', opts = {}}`                    | Manage the list of plugins you use in your setup.            |
| **Plugin-specific configuration** | `after/plugin/plugin_name.lua`| `require('oil').setup({...})`                         | Detailed configurations that require a plugin to be already loaded. |

---

## 🛠️ Key Conventions

To ensure efficient maintenance and clear understanding, adhere to these conventions:

1.  **Layered Configuration**: My setup uses a layered approach for better organization:
    * **Basic** (`set.lua`): Defines the editor's fundamental settings.
    * **Plugins** (`lazy.lua`): Manages the declaration and initial loading of your plugins.
    * **Specific** (`after/plugin/`): Contains detailed plugin configurations, which run once the plugin is ready.
2.  **Implicit Order**: Files within `after/plugin/` are loaded in **alphabetical order**. Keep this in mind if the loading sequence is critical for any of your plugins.
3.  **"Auto-Magic" System**: A significant advantage is that you don't need to explicitly use `require()` for files in `after/plugin/*.lua`. Neovim automatically loads them at the end of the initialization process, simplifying your configuration management.

---

## 💡 Practical Example: Adding a New Plugin

Adding a new plugin is a straightforward process when following this structure:

1.  **Plugin Declaration** (in `lua/fabri/lazy.lua`):
    Open `lua/fabri/lazy.lua` and add the entry for your new plugin within the `return {}` table. You can include basic options here using `opts = {}`.
    ```lua
    return {
      -- ... other existing plugins ...
      {'new/plugin', opts = {}}, -- Add this line for your new plugin.
                                  -- If the configuration is simple, you can put it in 'opts'.
    }
    ```
2.  **Advanced Configuration** (create `after/plugin/new_plugin.lua`):
    If the plugin requires a more complex setup or a dedicated `setup()` function call, create a new file in the `after/plugin/` directory. Give it a descriptive name, like `new_plugin.lua`.
    ```lua
    -- Content of after/plugin/new_plugin.lua
    require('plugin_name').setup({
      -- Place specific and detailed options for your plugin here.
      -- For example:
      -- keymaps = {
      --   next_item = "<C-n>",
      --   prev_item = "<C-p>",
      -- },
    })
    ```

---

## ⚠️ Important Notes

* Always run **`:Lazy clean`** followed by **`:Lazy sync`** in Neovim after making changes to `lua/fabri/lazy.lua` (adding, removing, or modifying plugins). This ensures Lazy.nvim correctly manages your dependencies.
* Changes made to files within `after/plugin/` are applied when you **reload Neovim** or execute `:luafile %` if you're editing the active file.
* The **`lazy-lock.json` file is automatically managed** by Lazy.nvim. Do not edit it manually! Its purpose is to lock your plugin versions for consistency across your setup.
