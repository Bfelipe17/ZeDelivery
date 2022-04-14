defmodule ZeDelivery.Partner.GetTest do
  use ZeDelivery.DataCase, async: true

  import ZeDelivery.Factory

  alias ZeDelivery.Partner.Get

  describe "call/1" do
    test "when user exist, return the user" do
      id = 1

      insert(:partner, id: id)

      response = Get.by_id(id)

      assert {:ok,
              %ZeDelivery.Partner{id: _id, ownerName: "Ze da Ambev", tradingName: "Adega Osasco"}} =
               response
    end

    test "when the user does not exist, return an error" do
      id = 2

      response = Get.by_id(id)

      assert {:error, _message} = response
    end
  end
end
