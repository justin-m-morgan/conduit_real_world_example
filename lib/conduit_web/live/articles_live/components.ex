defmodule ConduitWeb.ArticlesLive.Components do
  use ConduitWeb, :html

  slot(:tabbed_nav)
  slot(:feed)
  slot(:tags)

  def page_container(assigns) do
    ~H"""
    <div class={["container"]}>
      <main>
        <%= render_slot(@tabbed_nav) %>
        <%= render_slot(@feed) %>
      </main>

      <aside>
        <%= render_slot(@tags) %>
      </aside>
    </div>
    """
  end

  attr(:class, :any, default: nil)
  attr(:selected_tag, :string)

  def tabbed_nav(assigns) do
    ~H"""
    <.tabs>
      <:tab navigate="/" text="Global" />
      <:tab navigate="/" text="Mine" />
      <:tab status={:current} navigate="/" text="Friends" />
      <:tab
        navigate="/"
        text={@selected_tag}
        status={if(@selected_tag, do: :default, else: :disabled)}
      />
    </.tabs>
    """
  end

  slot(:author_badge, required: true)
  slot(:like_count, required: true)
  slot(:article_preview, required: true)
  slot(:read_more, required: true)
  slot(:article_tags, required: true)

  def feed_item(assigns) do
    ~H"""
    <div class="grid gap-2">
      <div class="flex justify-between items-center">
        <%= render_slot(@author_badge) %>
        <%= render_slot(@like_count) %>
      </div>
      <div>
        <%= render_slot(@article_preview) %>
      </div>
      <div class="flex justify-between">
        <%= render_slot(@read_more) %>
        <%= render_slot(@article_tags) %>
      </div>
    </div>
    """
  end

  attr(:author, :map, required: true)
  attr(:published_on, Date, required: true)

  def author_badge(assigns) do
    ~H"""
    <div class="flex gap-4 items-center">
      <div class="w-10 h-10 rounded-full bg-red-400"></div>

      <div class="flex flex-col justify-center">
        <span class="font-bold text-blue-600"><%= @author.name %></span>
        <span class="text-gray-500 text-sm"><%= @published_on %></span>
      </div>
    </div>
    """
  end

  attr(:likes, :integer, default: 0)

  def like_count(assigns) do
    ~H"""
    <.badge>
      <div>
        <.icon name="hero-heart" />
        <%= @likes %>
      </div>
    </.badge>
    """
  end

  attr(:article, :map, required: true)

  def article_preview(assigns) do
    ~H"""
    <div>
      <h3 class="font-bold"><%= @article.title %></h3>
      <p class="text-sm text-gray-600"><%= String.slice(@article.body, 0..100) %>...</p>
    </div>
    """
  end

  attr(:link_to, :string, required: true)

  def read_more(assigns) do
    ~H"""
    <.link navigate={@link_to} class="text-gray-400">
      Read more...
    </.link>
    """
  end

  attr(:class, :any, default: nil)
  attr(:tags, :list, default: [])

  def article_tags(assigns) do
    ~H"""
    <div class={["flex gap-2"]}>
      <%= for tag <- @tags do %>
        <.badge>
          <%= tag %>
        </.badge>
      <% end %>
    </div>
    """
  end

  attr(:active?, :boolean, default: false)
  attr(:text, :any, default: nil)
  attr(:link_to, :string, default: "#")
  attr(:rounded_left, :boolean, default: false)
  attr(:rounded_right, :boolean, default: false)

  def pagination_control(assigns) do
    ~H"""
    <li>
      <a
        href={@link_to}
        class={[
          "flex items-center justify-center",
          "px-3 h-8 ml-0",
          if(@active?,
            do: "text-blue-600 bg-blue-50 hover:text-blue-700 hover:bg-blue-100",
            else: "text-gray-500 dark:text-gray-400 bg-white dark:bg-gray-800"
          ),
          "leading-tight",
          "hover:bg-gray-100 hover:text-gray-700  dark:hover:bg-gray-700 dark:hover:text-white",
          "border border-gray-300   dark:border-gray-700",
          if(@rounded_left, do: "rounded-l-lg"),
          if(@rounded_right, do: "rounded-r-lg")
        ]}
      >
        <%= @text %>
      </a>
    </li>
    """
  end

  attr(:class, :any, default: nil)
  attr(:pages, :list, default: [])

  def pagination_controls(assigns) do
    ~H"""
    <nav aria-label="Page navigation example">
      <ul class="inline-flex -space-x-px text-sm">
        <.pagination_control text="Previous" link_to="#" rounded_left={true} />

        <%= for page <- @pages do %>
          <.pagination_control text={page.number} link_to={page.link_to} active?={page[:active]} />
        <% end %>

        <.pagination_control text="Next" link_to="#" rounded_right={true} />
      </ul>
    </nav>
    """
  end

  attr(:tags, :list, default: [])

  def tags(assigns) do
    ~H"""
    <.card>
      <h2 class="pb-2">Popular Tags</h2>
      <div class="flex flex-wrap gap-1">
        <%= for tag <- @tags do %>
          <.badge>
            <div class="flex gap-2">
              <span class=""><%= tag.name %></span>
              <span class="font-bold"><%= tag.count %></span>
            </div>
          </.badge>
        <% end %>
      </div>
    </.card>
    """
  end

  attr(:body, :string, default: "")

  def body_parser(assigns) do
    ~H"""
    <p>
      <%= @body %>
    </p>
    """
  end
end
