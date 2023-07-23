local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = 'python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
	{
		type="python";
		request="launch";
		name="ophanim";
		module="bmbi.ophanim";
	},
	{
		type="python";
		request="launch";
		name="thalamus";
		module="bmbi.thalamus";
	}
}

dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = 'C:\\Users\\jarl\\extension\\debugAdapters\\bin\\OpenDebugAD7',
  options = {
    detached = false
  }
}

dap.configurations.cpp = {
  {
    name = 'Attach',
    type = 'cppdbg',
    request = 'attach',
    processId = function() return vim.fn.input("PID:") end,
    miDebuggerPath = 'gdb',
    cwd = '${workspaceFolder}',
    program = "C:\\bmbi\\bmbi\\bmbi_native.exe"
  },
}
