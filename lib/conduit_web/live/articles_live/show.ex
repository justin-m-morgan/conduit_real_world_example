defmodule ConduitWeb.ArticlesLive.Show do
  use ConduitWeb, :live_view

  import ConduitWeb.ArticlesLive.Components

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:article, dummy_article())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""

    <div class="flex flex-col gap-4">
    <.jumbotron heading={@article.title} subheading={@article.promo_text}>
      <:actions>
        <div class="flex justify-center items-center gap-8">
          <.author_badge author={@article.author} published_on={@article.published_on} />
          <div class="flex flex-col gap-2">
            <.action_button
              text={"Follow " <> @article.author.name}
              icon="hero-eye"
              icon_text={@article.author.follower_count}
            />
            <.action_button text="Favorite Article" icon="hero-heart" icon_text={@article.like_count} />
          </div>
        </div>
      </:actions>
    </.jumbotron>
    <.body_parser body={@article.body} />

    <div>
      <h3 class="font-bold text-xl pb-4">Tags</h3>
      <div class="flex gap-2">
        <%= for tag <- @article.tags do %>
          <.badge>
            <%= tag %>
          </.badge>
        <% end %>
      </div>

      <hr class="mt-4"/>
      <div>
        <div class="flex justify-center items-center gap-8">
          <.author_badge author={@article.author} published_on={@article.published_on} />
          <div class="flex flex-col gap-2 py-8">
            <.action_button
              text={"Follow " <> @article.author.name}
              icon="hero-eye"
              icon_text={@article.author.follower_count}
            />
            <.action_button text="Favorite Article" icon="hero-heart" icon_text={@article.like_count} />
          </div>
        </div>
      </div>
    </div>
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
