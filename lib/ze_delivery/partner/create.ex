defmodule ZeDelivery.Partner.Create do
  alias ZeDelivery.{Partner, Repo}

  def call(params) do
    params
    |> Partner.changeset()
    |> Repo.insert()
  end
end
