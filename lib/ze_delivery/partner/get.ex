defmodule ZeDelivery.Partner.Get do
  alias ZeDelivery.{Partner, Repo}
  import Ecto.Query, warn: false

  def by_id(id) do
    case Repo.get(Partner, id) do
      [nil] -> {:error, "Partner does not exist"}
      partner -> {:ok, partner}
    end
  end

  def all() do
    case Repo.all(Partner) do
      [] -> {:error, "No partner registered"}
      partners -> {:ok, partners}
    end
  end

  def all(limit, cursor \\ nil, next \\ true) do
    case cursor do
      nil ->
        handle_all(limit)

      cursor ->
        handle_all(limit, cursor, next)
    end
  end

  def handle_all(limit) do
    query =
      from p in Partner,
        select: %{id: p.id, name: p.ownerName},
        order_by: p.id

    %{entries: entries, metadata: %{before: before_cursor, after: after_cursor}} =
      Repo.paginate(query, cursor_fields: [:id], limit: limit)

    {:ok, entries, before_cursor, after_cursor}
  end

  defp handle_all(limit, cursor, _next = true) do
    query =
      from p in Partner,
        select: %{id: p.id, name: p.ownerName},
        order_by: p.id

    %{entries: entries, metadata: %{before: before_cursor, after: after_cursor}} =
      Repo.paginate(query, after: cursor, cursor_fields: [:id], limit: limit)

    {:ok, entries, before_cursor, after_cursor}
  end

  # defp handle_all(limit, cursor, _next_cursor = false) do
  #   query =
  #     from p in Partner,
  #       select: %{id: p.id, name: p.ownerName},
  #       order_by: p.id

  #   %{entries: entries, metadata: %{before: before_cursor, after: after_cursor}} =
  #     Repo.paginate(query, after: cursor, cursor_fields: [:id], limit: limit)

  #   {:ok, before_cursor, entries, after_cursor}
  # end
end
