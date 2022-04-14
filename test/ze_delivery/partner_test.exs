defmodule ZeDelivery.PartnerTest do
  use ZeDelivery.DataCase, async: true

  import ZeDelivery.Factory

  alias ZeDelivery.Partner

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:partner_params)

      response = Partner.changeset(params)
      assert %Ecto.Changeset{valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:partner_params, %{document: "123"})

      response = Partner.changeset(params)

      expected_response = %{document: ["should be at least 11 character(s)"]}
      assert expected_response == errors_on(response)
    end
  end
end
