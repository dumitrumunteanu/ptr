defmodule Worker do
  def start_link(id) do
    pid = spawn_link(__MODULE__, :loop, [id])
    {:ok, pid}
  end

  def loop(id) do
    receive do
      {:echo, message} ->
        IO.puts("Worker #{id}: #{message}")
        loop(id)

      {:die} ->
        IO.puts("Worker #{id} has been killed")
        exit(:kill)
    end
  end
end

defmodule WorkerSupervisor do
  use Supervisor

  def start_link(n) do
    Supervisor.start_link(__MODULE__, n, name: __MODULE__)
  end

  @impl true
  def init(n) do
    children = 1..n |> Enum.map(fn workerId ->
      %{
        id: workerId,
        start: {Worker, :start_link, [workerId]}
      }
    end)

    IO.puts("Starting workers with ids 1-#{n}")
    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_worker_by_id(id) do
    {_id, pid, _, _} =
      __MODULE__
      |> Supervisor.which_children()
      |> Enum.find(fn {worker_id, _, _, _} -> worker_id == id end)

    pid
  end
end
