defmodule Conduit.Repo.Migrations.CreateArticleLikesTable do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :author_id, references(:authors, on_delete: :nothing)
      add :article_id, references(:articles, on_delete: :nothing)

      timestamps()
    end
  end
end
