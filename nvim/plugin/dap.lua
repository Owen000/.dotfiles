vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	once = true,
	callback = function()
		vim.pack.add({
			{ src = "https://github.com/mfussenegger/nvim-dap" },
			{ src = "https://github.com/nvim-neotest/nvim-nio" },
			{ src = "https://github.com/rcarriga/nvim-dap-ui" },
			{ src = "https://github.com/leoluz/nvim-dap-go" },
		})

		local dap = require("dap")
		local dapui = require("dapui")
		local dap_go = require("dap-go")

		dapui.setup()
		dap_go.setup()

		dap.listeners.after.event_initialized.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn" })
		vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticOk", linehl = "Visual" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })

		local function map(key, action, desc, mode)
			vim.keymap.set(mode or "n", "<leader>D" .. key, action, { silent = true, desc = desc })
		end

		map("b", dap.toggle_breakpoint, "Toggle breakpoint")
		map("B", function()
			vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
				if condition and condition ~= "" then
					dap.set_breakpoint(condition)
				end
			end)
		end, "Set conditional breakpoint")
		map("l", function()
			vim.ui.input({ prompt = "Log point message: " }, function(message)
				if message and message ~= "" then
					dap.set_breakpoint(nil, nil, message)
				end
			end)
		end, "Set log point")
		map("x", dap.clear_breakpoints, "Clear all breakpoints")
		map("c", dap.continue, "Start / continue debugging")
		map("o", dap.step_over, "Step over (F3)")
    map("i", dap.step_into, "Step into (F4)")
		map("O", dap.step_out, "Step out (F5)")
		vim.keymap.set("n", "<F3>", dap.step_over, { silent = true, desc = "Debug: step over" })
		vim.keymap.set("n", "<F4>", dap.step_into, { silent = true, desc = "Debug: step into" })
		vim.keymap.set("n", "<F5>", dap.step_out, { silent = true, desc = "Debug: step out" })
		map("p", dap.pause, "Pause debugging")
		map("r", dap.restart, "Restart debugging")
		map("R", dap.run_last, "Run last debug configuration")
		map("q", function()
			dap.terminate()
			dapui.close()
		end, "Stop debugging")
		map("u", dapui.toggle, "Toggle debug UI")
		map("e", dapui.eval, "Evaluate expression", { "n", "x" })
		map("s", dap.repl.toggle, "Toggle debug REPL")
		map("gt", dap_go.debug_test, "Debug Go test under cursor")
		map("gl", dap_go.debug_last_test, "Debug last Go test")
		map("gp", function()
			if vim.bo.filetype ~= "go" then
				vim.notify("Open a Go file to debug its package", vim.log.levels.WARN)
				return
			end
			dap.run({
				type = "go",
				name = "Debug Go package",
				request = "launch",
				program = "${fileDirname}",
				cwd = "${fileDirname}",
			})
		end, "Debug Go package")
	end,
})
