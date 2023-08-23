defmodule ConduitWeb.ArticlesLive.Show do
  use ConduitWeb, :live_view

  import ConduitWeb.ArticlesLive.Components

  alias Conduit.Articles

  def mount(params, _session, socket) do
    article_id = String.to_integer(params["id"])

    Process.send_after(self(), {:set_article, article_id}, 1000)

    socket =
      socket
      |> assign(:article_id, article_id)
      |> assign_new(:article, fn -> nil end)

    {:ok, socket}
  end

  def handle_info({:set_article, article_id}, socket) do
    IO.inspect(article_id, label: "article_id")
    article = Articles.get_article!(article_id, preload: [:author, :likes])
    IO.inspect(article, label: "article")
    {:noreply, assign(socket, :article, article)}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-4">
      <%= if @article do %>
        <.jumbotron heading={@article.title} subheading={@article.promo_text}>
          <:actions>
            <div class="flex justify-center items-center gap-8">
              <.author_badge
                author={@article.author}
                published_on={NaiveDateTime.to_date(@article.inserted_at)}
              />
              <div class="flex flex-col gap-2">
                <.action_button
                  text={"Follow " <> @article.author.name}
                  icon="hero-eye"
                  icon_text={0 || @article.author.follower_count}
                />
                <.action_button
                  text="Favorite Article"
                  icon="hero-heart"
                  icon_text={length(@article.likes)}
                />
              </div>
            </div>
          </:actions>
        </.jumbotron>

        <.body_parser body={@article.body} />

        <div>
          <h3 class="font-bold text-xl pb-4">Tags</h3>
          <div class="flex gap-2">
            <%!-- <%= for tag <- @article.tags do %> --%>
            <%= for tag <- ["tag 1", "tag 2"] do %>
              <.badge>
                <%= tag %>
              </.badge>
            <% end %>
          </div>

          <hr class="mt-4" />
          <div>
            <div class="flex justify-center items-center gap-8">
              <.author_badge
                author={@article.author}
                published_on={NaiveDateTime.to_date(@article.inserted_at)}
              />
              <div class="flex flex-col gap-2 py-8">
                <%!-- TODO: Add author follower count when available --%>
                <.action_button
                  text={"Follow " <> @article.author.name}
                  icon="hero-eye"
                  icon_text={0 || @article.author.follower_count}
                />

                <.action_button
                  text="Favorite Article"
                  icon="hero-heart"
                  icon_text={length(@article.likes)}
                />
              </div>
            </div>
          </div>
        </div>
      <% else %>
        <div>Loading...</div>
      <% end %>
    </div>
    """
  end

  attr(:text, :string, required: true)
  attr(:icon, :string, required: true)
  attr(:icon_text, :string, default: "")

  def action_button(assigns) do
    ~H"""
    <.badge>
      <div class="flex justify-between gap-6">
        <span>
          <.icon name={@icon} />
          <%= @icon_text %>
        </span>
        <span>
          <%= @text %>
        </span>
      </div>
    </.badge>
    """
  end

  def dummy_article do
    %{
      id: 1,
      author: %{
        name: "John Doe",
        follower_count: 100
      },
      published_on: ~D"2021-01-01",
      like_count: 10,
      title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      promo_text:
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor.",
      body:
        "I was gonna take the time to sit down and write you a little letter. But I thought a song would probably be a little better. Instead of a ,letter. That you'd probably just shred up--yeah. I stumbled on your picture yesterday and it made me stop and think of. How much of a waste it'd ,be for me to put some ink to, a stupid piece a. Paper, I'd rather let you see how. Much I fucking hate you in a freestyle.",
      tags: [
        "ajsdflj",
        "sj",
        "lsdajf askdj jd"
      ]
    }
  end
end
