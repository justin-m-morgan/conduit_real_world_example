defmodule Conduit.Repo.Migrations.CreateArticles do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :body, :text
      add :title, :string
      add :slug, :string
      add :promo_text, :string
      add :author_id, references(:authors, on_delete: :nothing)

      timestamps()
    end

    create index(:articles, [:author_id])
  end
end
