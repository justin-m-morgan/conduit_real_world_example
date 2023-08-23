defmodule ConduitWeb.ArticlesLive.Index do
  use ConduitWeb, :live_view

  import ConduitWeb.ArticlesLive.Components

  alias Conduit.Articles

  def mount(_params, _session, socket) do
    all_articles = Articles.list_articles(preload: [:author, :likes])
    IO.inspect(all_articles)

    socket =
      socket
      |> assign(:feed, all_articles)
      |> assign(:tags, dummy_tags())
      |> assign(:selected_tag, nil)
      |> assign(:pagination_items, dummy_pagination_items())

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container grid grid-cols-3 gap-8">
      <div class="col-span-2 grid gap-4">
        <.tabbed_nav selected_tag={@selected_tag} />
        <div class="grid gap-8">
          <%= for item <- @feed do %>
            <.feed_item>
              <:author_badge>
                <.author_badge
                  author={item.author}
                  published_on={NaiveDateTime.to_date(item.inserted_at)}
                />
              </:author_badge>
              <:like_count>
                <.like_count likes={length(item.likes)} />
              </:like_count>

              <:article_preview>
                <.article_preview article={item} />
              </:article_preview>
              <:read_more>
                <.read_more link_to={~p[/articles/#{item.id}]} />
              </:read_more>
              <:article_tags>
                <.article_tags tags={["tag 1", "tag 2"]} />
              </:article_tags>
            </.feed_item>
          <% end %>

          <div class="flex justify-center">
            <.pagination_controls pages={@pagination_items} />
          </div>
        </div>
      </div>
      <div>
        <.tags tags={@tags} />
      </div>
    </div>
    """
  end

  def dummy_content_feed do
    [
      %{
        id: 1,
        author: %{
          name: "John Doe"
        },
        published_on: ~D"2021-01-01",
        like_count: 10,
        title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        body:
          "I was gonna take the time to sit down and write you a little letter. But I thought a song would probably be a little better. Instead of a ,letter. That you'd probably just shred up--yeah. I stumbled on your picture yesterday and it made me stop and think of. How much of a waste it'd ,be for me to put some ink to, a stupid piece a. Paper, I'd rather let you see how. Much I fucking hate you in a freestyle.",
        tags: [
          "ajsdflj",
          "sj",
          "lsdajf askdj jd"
        ]
      },
      %{
        id: 2,
        author: %{
          name: "Jane Doe III"
        },
        published_on: ~D"2021-02-05",
        like_count: 100,
        title: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        body:
          "I was gonna take the time to sit down and write you a little letter. But I thought a song would probably be a little better. Instead of a ,letter. That you'd probably just shred up--yeah. I stumbled on your picture yesterday and it made me stop and think of. How much of a waste it'd ,be for me to put some ink to, a stupid piece a. Paper, I'd rather let you see how. Much I fucking hate you in a freestyle.",
        tags: [
          "ajsdflj",
          "lsdajf askdj jd",
          "sj"
        ]
      }
    ]
  end

  def dummy_tags do
    [
      %{name: "foo", count: 1},
      %{name: "bar", count: 1},
      %{name: "bar asdkjfa", count: 20},
      %{name: "baz ewi", count: 3},
      %{name: "qux eioj aksdfj", count: 100},
      %{name: "ej", count: 2}
    ]
  end

  def dummy_pagination_items do
    [
      %{number: 1, link_to: "#"},
      %{number: 2, link_to: "#", active: true},
      %{number: 3, link_to: "#"}
    ]
  end
end
