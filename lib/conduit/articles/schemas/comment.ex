defmodule Conduit.Articles.Schemas.Comment do
  use Ecto.Schema

  import Ecto.Changeset

  schema "comments" do
    field :body, :string

    belongs_to :article, Conduit.Articles.Schemas.Article
    belongs_to :author, Conduit.Authors.Author

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author_id, :article_id, :body])
    |> validate_required([:author_id, :article_id, :body])
  end
end
