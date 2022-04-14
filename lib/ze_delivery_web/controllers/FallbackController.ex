defmodule ZeDeliveryWeb.FallbackController do
  use ZeDeliveryWeb, :controller

  alias Ecto.Changeset
  alias ZeDeliveryWeb.ErrorView

  def call(conn, {:error, message: message}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render("error.json", message: message)
  end

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(ErrorView)
    |> render("error.json", message: changeset)
  end
end
