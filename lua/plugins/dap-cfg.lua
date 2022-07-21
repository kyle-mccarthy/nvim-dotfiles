local dap = require('dap')

--[[ dap.adapters.codelldb = function(on_adapter)
  -- get a free port from the system
  local server = vim.loop.new_tcp()
  server:bind('127.0.0.1', 0)

  local port = server:getsockname().port
  server:shutdown()
  server:close()

  -- start codelldb on the port
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)

  local opts = {
    stdio = {nil, stdout, stderr},
    args = {'--port', tostring(port)}
  }

  local cmd = "/Users/kylemccarthy/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb"

  local handle, pid_or_err

  handle, pid_or_err = vim.loop.spawn(
                         cmd, opts, function(code)
      stdout:close()
      stderr:close()
      handle:close()
      if code ~= 0 then
        print("codelldb exited with code", code)
      end
    end
                       )

  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end

  vim.notify('codelldb started. pid=' .. pid_or_err)

  stderr:read_start(
    function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(
          function()
            require("dap.repl").append(chunk)
          end
        )
      end
    end
  )

  local adapter = {type = 'server', host = '127.0.0.1', port = port}

  vim.defer_fn(
    function()
      on_adapter(adapter)
    end, 500
  )

end ]]

--[[ dap.adapters.codelldb = function(on_adapter)
  -- This asks the system for a free port
  local tcp = vim.loop.new_tcp()
  tcp:bind('127.0.0.1', 0)
  local port = tcp:getsockname().port
  tcp:shutdown()
  tcp:close()

  -- Start codelldb with the port
  local stdout = vim.loop.new_pipe(false)
  local stderr = vim.loop.new_pipe(false)
  local opts = {
    stdio = {nil, stdout, stderr},
    args = {'--port', tostring(port)},
  }
  local handle
  local pid_or_err
  handle, pid_or_err = vim.loop.spawn(cmd, opts, function(code)
    stdout:close()
    stderr:close()
    handle:close()
    if code ~= 0 then
      print("codelldb exited with code", code)
    end
  end)
  if not handle then
    vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
    stdout:close()
    stderr:close()
    return
  end
  vim.notify('codelldb started. pid=' .. pid_or_err)
  stderr:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  local adapter = {
    type = 'server',
    host = '127.0.0.1',
    port = port
  }
  -- 💀
  -- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
  -- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
  vim.defer_fn(function() on_adapter(adapter) end, 500)
end ]]

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local get_codelldb_adapter = function(port)
  return function(callback, _)
    local stdout = vim.loop.new_pipe(false)
    local stderr = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local error_message = ""

    local opts = {
      stdio = {nil, stdout, stderr},
      args = {"--liblldb", liblldb_path, "--port", port},
      detached = true
    }

    handle, pid_or_err = vim.loop.spawn(
                           codelldb_path, opts, function(code)
        stdout:close()
        stderr:close()
        handle:close()
        if code ~= 0 then
          print("codelldb exited with code", code)
          print("error message", error_message)
        end
      end
                         )

    assert(handle, "Error running codelldb: " .. tostring(pid_or_err))

    stdout:read_start(
      function(err, chunk)
        assert(not err, err)
        if chunk then
          vim.schedule(
            function()
              require("dap.repl").append(chunk)
            end
          )
        end
      end
    )
    stderr:read_start(
      function(_, chunk)
        if chunk then
          error_message = error_message .. chunk

          vim.schedule(
            function()
              require("dap.repl").append(chunk)
            end
          )
        end
      end
    )
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end, 100
    )
  end
end


dap.adapters.codelldb = get_codelldb_adapter(0)

dap.configurations.rust = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    runInTerminal = false
  },
  {
    name = "Attach to process",
    type = 'codelldb', -- Adjust this to match your adapter name (`dap.adapters.<name>`)
    request = 'attach',
    pid = require('dap.utils').pick_process,
    args = {}
  }
}
