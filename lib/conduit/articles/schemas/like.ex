defmodule Conduit.Articles.Schemas.Like do
  use Ecto.Schema

  import Ecto.Changeset

  schema "likes" do
    belongs_to :author, Conduit.Authors.Author
    belongs_to :article, Conduit.Articles.Schemas.Article

    timestamps()
  end

  @doc false
  def changeset(like, attrs) do
    like
    |> cast(attrs, [:author_id, :article_id])
    |> validate_required([:author_id, :article_id])
  end
end
