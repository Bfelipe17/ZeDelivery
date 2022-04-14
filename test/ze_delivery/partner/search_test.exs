defmodule ZeDelivery.Partner.SearchTest do
  use ZeDelivery.DataCase, async: true

  import ZeDelivery.Factory

  alias ZeDelivery.Partner.{Create, Search}

  describe "by_location/2" do
    test "when have partners who deliver to the given location, return a partner" do
      build(:partner_params)
      |> Create.call()

      response = Search.by_location(-49.35, -25.40)

      assert {:ok, _partners} = response
    end

    test "when doesn't have partner who deliver to the given location, return an error message" do
      build(:partner_params)
      |> Create.call()

      response = Search.by_location(-1, -1)

      assert {:error, _partner_message_not_found} = response
    end
  end
end
