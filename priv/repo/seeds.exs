# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ZeDelivery.Repo.insert!(%ZeDelivery.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Seeds do
  alias ZeDelivery.Partner.Create

  def call() do
    with body <- File.read!("pdvs.json"),
         content <- Jason.decode!(body),
         partners <- getPdvs(content) do
      partners
      |> Enum.map(&insert(&1))
    end
  end

  defp getPdvs(%{"pdvs" => partners}), do: partners

  defp insert(%{
         "address" => address,
         "coverageArea" => coverageArea,
         "document" => document,
         "ownerName" => ownerName,
         "tradingName" => tradingName
       }) do
    params = %{
      address: convertToGEO(address),
      coverageArea: convertToGEO(coverageArea),
      document: document,
      ownerName: ownerName,
      tradingName: tradingName
    }

    Create.call(params)
  end

  defp convertToGEO(data) do
    data
    |> Jason.encode!()
    |> Jason.decode!()
    |> Geo.JSON.decode!()
  end
end

Seeds.call()
