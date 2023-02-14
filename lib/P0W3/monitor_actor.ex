defmodule MonitorActor do
  def start(targetPid) do
    spawn(fn -> loop(targetPid) end)
  end

  defp loop(targetPid) do
    Process.monitor(targetPid)

    receive do
      {:DOWN, _ref, :process, _targetPid, reason} ->
        IO.puts("Actor stopped: #{reason}")
    end
  end
end
