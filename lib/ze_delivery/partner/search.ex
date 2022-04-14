defmodule ZeDelivery.Partner.Search do
  import Ecto.Query, warn: false
  import Geo.PostGIS

  alias ZeDelivery.Repo
  alias ZeDelivery.Partner

  def by_location(long, lat) do
    format_location(long, lat)
    |> do_query()
  end

  defp format_location(long, lat) when is_bitstring(long) and is_bitstring(lat) do
    {longitude, _} = Float.parse(long)
    {latitude, _} = Float.parse(lat)

    create_location(longitude, latitude)
  end

  defp format_location(long, lat), do: create_location(long, lat)

  defp create_location(long, lat) do
    %Geo.Point{
      coordinates: {long, lat}
    }
  end

  defp do_query(location) do
    query =
      from p in Partner,
        select: %{
          id: p.id,
          ownerName: p.ownerName,
          tradingName: p.tradingName,
          address: p.address,
          coverageArea: p.coverageArea,
          distance: st_distance_in_meters(p.address, ^location)
        },
        limit: 1,
        where: st_contains(p.coverageArea, ^location),
        order_by: st_distance_in_meters(p.address, ^location)

    query
    |> Repo.one()
    |> handle_partners()
  end

  defp handle_partners(nil),
    do: {:error, "There is no partner that delivers to your address"}

  defp handle_partners(partners), do: {:ok, partners}
end
