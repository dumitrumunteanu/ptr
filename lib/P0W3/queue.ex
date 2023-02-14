defmodule Queue do
  def start() do
    spawn(fn -> loop([]) end)
  end

  def push(pid, item) do
    send(pid, {:push, item})
  end

  def pop(pid) do
    send(pid, :pop)
  end

  defp loop(queue) do
    receive do
      {:push, item} ->
        loop(queue ++ [item])

      :pop ->
        case queue do
          [] ->
            IO.puts("Queue is empty")
            loop([])
          [head | tail] ->
            IO.puts(head)
            loop(tail)
        end
    end
  end
end
