if true then return {
	"nvim-java/nvim-java",
}
end

return {
	"nvim-java/nvim-java",
	dependencies = {
		{
			"neovim/nvim-lspconfig",
		  "williamboman/mason.nvim",
			"nvim-java/nvim-java-core",
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"nvim-java/nvim-java-refactor",
			"MunifTanjim/nui.nvim",
			"mfussenegger/nvim-dap",
			opts = {
				servers = {
					-- Your JDTLS configuration goes here
					jdtls = {
						-- settings = {
						--   java = {
						--     configuration = {
						--       runtimes = {
						--         {
						--           name = "JavaSE-23",
						--           path = "/usr/local/sdkman/candidates/java/23-tem",
						--         },
						--       },
						--     },
						--   },
						-- },
					},
				},
				setup = {
					jdtls = function()
						-- Your nvim-java configuration goes here
						require("java").setup({
							root_markers = {
								"package-info.java",
								".vscode",
								-- "settings.gradle",
								-- "pom.xml",
								-- "build.gradle",
								-- "mv[nw",
								-- "gradlew",
								-- "build.gradle",
								".git",
							},
						})
				    local lspconfig = require("lspconfig")
            lspconfig.jdtls.setup({})
					end,
				},
			},
		},
	},
}

-- return {
--   "nvim-java/nvim-java",
--   dependencies = {
--     "nvim-java/lua-async-await",
--     "nvim-java/nvim-java-core",
--     "nvim-java/nvim-java-test",
--     "nvim-java/nvim-java-dap",
--     "nvim-java/nvim-java-refactor",
--     "MunifTanjim/nui.nvim",
--     "mfussenegger/nvim-dap",
--     "neovim/nvim-lspconfig",
--     "williamboman/mason.nvim",
--     -- {
--     -- 	"williamboman/mason.nvim",
--     -- 	opts = {
--     -- 		registries = {
--     -- 			"github:nvim-java/mason-registry",
--     -- 			"github:mason-org/mason-registry",
--     -- 		},
--     -- 	},
--     -- },
--     opts = {
--       servers = {
--         jdtls = {
--           -- Your custom jdtls settings goes here
--           -- use_lombok_agent = true,
--           -- vmargs = {
--           -- 	"-javaagent:~/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar",
--           -- 	--"-Xbootclasspath/a:~/.local/share/nvim/mason/packages/lombok-nightly/lombok.jar",
--           -- },
--         },
--       },
--       setup = {
--         jdtls = function()
--           require("java").setup({
--             root_markers = {
--               "package-info.java",
--               ".vscode",
--               -- "settings.gradle",
--               -- "pom.xml",
--               -- "build.gradle",
--               -- "mvnw",
--               -- "gradlew",
--               -- "build.gradle",
--               ".git",
--             },
--             capabilities = require("cmp_nvim_lsp").default_capabilities(
--               vim.lsp.protocol.make_client_capabilities()
--             ),
--           })
--         end,
--       },
--     },
--   },
-- }
