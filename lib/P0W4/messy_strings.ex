defmodule Splitter do
  def start_link() do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A splitter process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop() do
    receive do
      {string} ->
        strings = string |> String.split()

        IO.puts("\"#{string}\" was split into #{inspect(strings)}")

        {_, swapper, _, _} = FormatterSupervisor |> Supervisor.which_children |> Enum.at(1)
        send(swapper, {strings})

        loop()
    end
  end
end

defmodule Swapper do
  def start_link() do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A swapper process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop() do
    receive do
      {strings} ->
        transformed_strs = strings |> Enum.map(fn string ->
          string
          |> String.downcase
          |> String.replace("m", "__temp__")
          |> String.replace("n", "m")
          |> String.replace("__temp__", "n")
        end)

        IO.puts("\"#{inspect(strings)}\" was transformed into #{inspect(transformed_strs)}")

        {_, joiner, _, _} = FormatterSupervisor |> Supervisor.which_children |> Enum.at(0)
        send(joiner, {transformed_strs})

        loop()
    end
  end
end

defmodule Joiner do
  def start_link() do
    pid = spawn_link(__MODULE__, :loop, [])
    IO.puts("A joiner process has started at #{inspect(pid)}.")
    {:ok, pid}
  end

  def loop() do
    receive do
      {strings} ->
        joined_list = strings |> Enum.join(" ")

        IO.puts("#{inspect(strings)} joined into \"#{joined_list}\"")

        loop()
    end
  end
end

defmodule FormatterSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    children = [
      %{
        id: :splitter,
        start: {Splitter, :start_link, []}
      },
      %{
        id: :swapper,
        start: {Swapper, :start_link, []}
      },
      %{
        id: :joiner,
        start: {Joiner, :start_link, []}
      }
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

  def process_message(message) do
    {_, splitter, _, _} = __MODULE__ |> Supervisor.which_children |> Enum.at(2)

    send(splitter, {message})
  end
end
