defmodule AverageActor do
  def start() do
    spawn(fn -> average(0.0) end)
  end

  defp average(avg) do
    IO.puts("Current average is #{avg}")
    receive do
      value -> average((avg + value) / 2)
    end
  end
end
