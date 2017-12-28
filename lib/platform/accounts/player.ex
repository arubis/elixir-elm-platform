defmodule Platform.Accounts.Player do
  use Ecto.Schema
  import Ecto.Changeset
  alias Platform.Accounts.Player


  schema "players" do
    field :score, :integer, default: 0
    field :username, :string, unique: true
    field :password, :string, virtual: true
    field :password_digest, :string
    field :display_name, :string

    timestamps()
  end

  @doc false
  def changeset(%Player{} = player, attrs) do
    player
    |> cast(attrs, [:username, :score, :display_name, :password])
    |> validate_required([:username])
    |> unique_constraint(:username)
    |> validate_length(:username, min: 2, max: 100)
    |> validate_length(:password, min: 6, max: 100)
    |> _put_pass_digest()
  end

  @doc false
  def registration_changeset(%Player{} = player, attrs) do
    player
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> unique_constraint(:username)
    |> validate_length(:username, min: 2, max: 100)
    |> validate_length(:password, min: 6, max: 100)
    |> _put_pass_digest()
  end

  defp _put_pass_digest(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_digest, Comeonin.Bcrypt.hashpwsalt(pass))

      _ ->
        changeset
    end
  end
end
