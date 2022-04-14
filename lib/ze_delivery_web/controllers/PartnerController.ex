defmodule ZeDeliveryWeb.PartnerController do
  use ZeDeliveryWeb, :controller

  alias ZeDelivery.Partner.{Create, Get, Search}

  action_fallback ZeDeliveryWeb.FallbackController

  def create(conn, params) do
    with {:ok, partner} <- Create.call(params) do
      IO.inspect(partner)

      conn
      |> put_status(:created)
      |> render("create.json", partner: partner)
    end
  end

  def show(conn, %{"long" => long, "lat" => lat}) do
    with {:ok, partner} <- Search.by_location(long, lat) do
      conn
      |> put_status(:ok)
      |> render("show.json", partner: partner)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, partner} <- Get.by_id(id) do
      conn
      |> put_status(:ok)
      |> render("show.json", partner: partner)
    end
  end

  def show(conn, %{"limit" => limit, "next_cursor" => cursor}) do
    with {:ok, partners, before_cursor, after_cursor} <- Get.all(limit, cursor, true) do
      conn
      |> put_status(:ok)
      |> render("show.json",
        partners: partners,
        before_cursor: before_cursor,
        after_cursor: after_cursor
      )
    end
  end

  def show(conn, %{"limit" => limit}) do
    with {:ok, partners, before_cursor, after_cursor} <- Get.all(limit) do
      conn
      |> put_status(:ok)
      |> render("show.json",
        partners: partners,
        before_cursor: before_cursor,
        after_cursor: after_cursor
      )
    end
  end

  def show(conn, _params) do
    with {:ok, partners} <- Get.all() do
      conn
      |> put_status(:ok)
      |> render("show.json", partners: partners)
    end
  end
end
