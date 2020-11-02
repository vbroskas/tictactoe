defmodule Tictac.Repo do
  use Ecto.Repo,
    otp_app: :tictac,
    adapter: Ecto.Adapters.Postgres
end
