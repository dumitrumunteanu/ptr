defmodule Scheduler do
  def start() do
    spawn(fn -> loop(nil) end)
  end

  def loop(pid) do
    Process.monitor(pid)

    receive do
      {:DOWN, _ref, :process, _targetPid, :failure} ->
        IO.puts("Task failed.")
        loop(getNewJob())

      {:job, _} -> loop(getNewJob())
    end
  end

  def getNewJob() do
    spawn(fn ->
      case :rand.uniform(2) do
        1 -> Process.exit(self(), :failure)
        2 -> IO.puts("Task succeded: MIAU")
      end
    end)
  end
end
