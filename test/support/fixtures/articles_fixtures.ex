defmodule Conduit.ArticlesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Conduit.Articles` context.
  """

  @doc """
  Generate a article.
  """
  def article_fixture(attrs \\ %{}) do
    {:ok, article} =
      attrs
      |> Enum.into(%{
        body: "some body",
        promo_text: "some promo_text",
        slug: "some slug",
        title: "some title"
      })
      |> Conduit.Articles.create_article()

    article
  end
end
