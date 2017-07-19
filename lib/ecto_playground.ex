defmodule EctoPlayground do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(EctoPlayground.DB, [])
      # Starts a worker by calling: EctoPlayground.Worker.start_link(arg1, arg2, arg3)
      # worker(EctoPlayground.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EctoPlayground.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule EctoPlayground.DB do
  use Ecto.Repo, otp_app: :ecto_playground
end

defmodule EctoPlayground.Person do
  use Ecto.Schema
  import Ecto.Query

  schema "people" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
  end

  def old_people do
    EctoPlayground.Person |> where("age > 60")
  end

  def changeset(person, params \\ %{}) do
    person
    |> Ecto.Changeset.cast(params, [:first_name, :age, :last_name])
    |> Ecto.Changeset.validate_required([:first_name, :last_name])
    |> Ecto.Changeset.unique_constraint(:last_name)
  end
end
