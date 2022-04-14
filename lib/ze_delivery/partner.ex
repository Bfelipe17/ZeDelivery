defmodule ZeDelivery.Partner do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @fields [:tradingName, :ownerName, :document, :coverageArea, :address]

  @derive {Jason.Encoder,
           only: [:id, :tradingName, :ownerName, :document, :coverageArea, :address]}

  schema "partners" do
    field :address, Geo.PostGIS.Geometry
    field :coverageArea, Geo.PostGIS.Geometry
    field :document, :string
    field :ownerName, :string
    field :tradingName, :string

    timestamps()
  end

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint([:document])
    |> validate_document()
    |> validate_length(:document, min: 11, max: 25)
  end

  defp validate_document(%Changeset{valid?: true, changes: %{document: document}} = changeset) do
    formated_document =
      document
      |> String.replace(".", "")
      |> String.replace("-", "")
      |> String.replace("/", "")
      |> verify_document()

    changeset
    |> change(document: formated_document)
  end

  defp validate_document(changeset), do: changeset

  def verify_document(document) do
    case String.length(document) do
      11 ->
        format_document(:cpf, document)

      14 ->
        format_document(:cnpj, document)

      _ ->
        document
    end
  end

  def format_document(:cnpj, document) do
    ~r/(\d{2})?(\d{3})?(\d{3})?(\d{4})?(\d{2})/
    |> Regex.replace(document, "\\1.\\2.\\3/\\4-\\5")
  end

  def format_document(:cpf, document) do
    ~r/(\d{3})?(\d{3})?(\d{3})?(\d{2})/
    |> Regex.replace(document, "\\1.\\2.\\3-\\4")
  end
end
