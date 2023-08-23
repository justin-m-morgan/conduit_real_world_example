defmodule Conduit.Articles.Schemas.Article do
  use Ecto.Schema
  import Ecto.Changeset

  schema "articles" do
    field :body, :string
    field :promo_text, :string
    field :slug, :string
    field :title, :string
    field :created, :naive_datetime

    has_many :comments, Conduit.Articles.Schemas.Comment
    has_many :likes, Conduit.Articles.Schemas.Like

    belongs_to :author, Conduit.Authors.Author

    timestamps()
  end

  @doc false
  def changeset(article, attrs) do
    article
    |> cast(attrs, [:author_id, :body, :promo_text, :slug, :title])
    |> validate_required([:author_id, :body, :title, :slug, :promo_text])
  end
end
