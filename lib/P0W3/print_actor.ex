defmodule PrintActor do
  def startPrintReceivedMessage() do
    spawn(fn -> printReceivedMessage() end)
  end

  defp printReceivedMessage() do
    receive do
      message ->
        IO.puts("Received message: #{message}")
        printReceivedMessage()
    end
  end

  def startPrintModifiedMessage() do
    spawn(fn -> printModifiedMessage() end)
  end

  defp printModifiedMessage() do
    receive do
      message when is_integer(message) ->
        IO.puts(message + 1)

      message when is_bitstring(message) ->
        IO.puts(message |> String.downcase())

      _ -> IO.puts("I do not know how to handle this")
    end

    printModifiedMessage()
  end
end
