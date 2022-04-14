defmodule ZeDelivery.Partner.CreateTest do
  use ZeDelivery.DataCase, async: true

  import ZeDelivery.Factory

  alias ZeDelivery.Partner.Create

  describe "call/1" do
    test "when all params are valid, return the user" do
      response =
        build(:partner_params, %{document: "12312312300"})
        |> Create.call()

      assert {:ok, _partner} = response
    end

    test "when there are some invalid param, returns an invalid changeset" do
      response =
        build(:partner_params, %{document: "123"})
        |> Create.call()

      assert {:error, changeset} = response
      assert %{document: ["should be at least 11 character(s)"]} == errors_on(changeset)
    end
  end
end
