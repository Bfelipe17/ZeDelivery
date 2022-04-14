defmodule ZeDelivery.Repo do
  use Ecto.Repo,
    otp_app: :ze_delivery,
    adapter: Ecto.Adapters.Postgres

  use Paginator
end
