defmodule Conduit.Repo.Migrations.CreateArticleCommentsTable do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :text

      add :author_id, references(:authors, on_delete: :nothing)
      add :article_id, references(:articles, on_delete: :nothing)

      timestamps()
    end
  end
end
