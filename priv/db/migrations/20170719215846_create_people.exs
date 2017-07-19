defmodule EctoPlayground.DB.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people) do
      add :first_name, :string
      add :last_name, :string, unique: true
      add :age, :integer
    end
    create unique_index(:people, :last_name)
  end
end
