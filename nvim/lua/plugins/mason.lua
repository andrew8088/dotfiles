return {

  "williamboman/mason.nvim",
  config = function(_, opts)
    require("mason").setup(opts)

    -- handle opts.ensure_installed
    local registry = require("mason-registry")
    registry.refresh(function()
      if opts.ensure_installed == nil then
        return
      end

      for _, pkg_name in ipairs(opts.ensure_installed) do
        -- print("loading " .. pkg_name)
        local pkg = registry.get_package(pkg_name)
        if not pkg:is_installed() then
          pkg:install()
        end
      end
    end)
  end,
}
