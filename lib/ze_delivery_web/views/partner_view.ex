defmodule ZeDeliveryWeb.PartnerView do
  use ZeDeliveryWeb, :view

  alias ZeDelivery.Partner

  def render("show.json", %{partner: partner}) do
    %{partner: partner}
  end

  def render("show.json", %{
        partners: partners,
        before_cursor: before_cursor,
        after_cursor: after_cursor
      }) do
    %{partners: partners, before_cursor: before_cursor, after_cursor: after_cursor}
  end

  def render("create.json", %{partner: %Partner{} = partner}) do
    %{
      message: "Partner created",
      partner: partner
    }
  end
end
