defmodule ConduitWeb.Layouts.Components do
  use ConduitWeb, :html

  def header(assigns) do
    ~H"""
    <header>
      <nav class="bg-white border-gray-200 px-4 lg:px-6 py-2.5 dark:bg-gray-800">
        <div class="flex flex-wrap items-center justify-between max-w-screen-xl mx-auto">
          <.logo link_to="/" text="Conduit" subtext="A place to share your knowledge" />

          <div class="flex items-center lg:order-2">
            <.navbar_item link_to="/" text="Log In" current?={false} />
            <.navbar_item link_to="/" text="Sign Up" current?={false} />

            <.sandwich_nav_menu_trigger />
          </div>
          <.sandwich_nav_menu nav_items={sandwich_nav_items()} />
        </div>
      </nav>
    </header>
    """
  end

  def footer(assigns) do
    ~H"""

    <footer class="bg-white rounded-lg dark:bg-gray-900">
    <div class="w-full max-w-screen-xl mx-auto p-4 md:py-8">
        <div class="sm:flex sm:items-center sm:justify-between">
            <.logo text="Conduit" />
            <ul class="flex flex-wrap items-center mb-6 text-sm font-medium text-gray-500 sm:mb-0 dark:text-gray-400">
                <li>
                    <a href="#" class="mr-4 hover:underline md:mr-6 ">About</a>
                </li>

                <li>
                    <a href="#" class="hover:underline">Contact</a>
                </li>
            </ul>
        </div>
        <hr class="my-6 border-gray-200 sm:mx-auto dark:border-gray-700 lg:my-8" />
        <%!-- <span class="block text-sm text-gray-500 sm:text-center dark:text-gray-400">© 2023 <a href="https://flowbite.com/" class="hover:underline">Flowbite™</a>. All Rights Reserved.</span> --%>
    </div>
    </footer>


    """
  end

  attr(:current?, :boolean, default: false)
  attr(:link_to, :string, required: true)
  attr(:text, :string, required: true)

  def navbar_item(assigns) do
    ~H"""
    <a
      href={@link_to}
      class={[
        "px-4 lg:px-5 py-2 lg:py-2",
        if(@current?,
          do: "text-white bg-blue-700 hover:bg-blue-800",
          else: "text-gray-800 dark:text-white "
        ),
        "font-medium text-sm",
        "dark:hover:bg-gray-700 rounded-lg",
        "hover:bg-gray-50",
        "focus:ring-4 focus:ring-gray-300 dark:focus:ring-gray-800 focus:outline-none"
      ]}
    >
      <%= @text %>
    </a>
    """
  end

  attr(:link_to, :string, default: "/")
  attr(:text, :string, required: true)
  attr(:subtext, :string, default: "")

  def logo(assigns) do
    ~H"""
    <a href={@link_to} class="flex items-center">
      <img
        src="https://flowbite.com/docs/images/logo.svg"
        class="h-32 mr-3 sm:h-9"
        alt={"#{@text} Logo"}
      />
      <div>
        <h1 class="text-xl font-semibold whitespace-nowrap dark:text-white">
          <%= @text %>
        </h1>
        <h2><%= @subtext %></h2>
      </div>
    </a>
    """
  end

  def sandwich_nav_menu_trigger(assigns) do
    ~H"""
    <button
      data-collapse-toggle="mobile-menu-2"
      type="button"
      class={[
        "lg:hidden",
        "p-2 ml-1",
        "text-sm text-gray-500 dark:text-gray-400 ",
        "hover:bg-gray-100 dark:hover:bg-gray-700",
        "focus:outline-none focus:ring-2 focus:ring-gray-200  dark:focus:ring-gray-600",
        "rounded-lg",
        "inline-flex items-center"
      ]}
      aria-controls="mobile-menu-2"
      aria-expanded="false"
    >
      <span class="sr-only">Open main menu</span>
      <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
        <path
          fill-rule="evenodd"
          d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
          clip-rule="evenodd"
        >
        </path>
      </svg>
      <svg
        class="hidden w-6 h-6"
        fill="currentColor"
        viewBox="0 0 20 20"
        xmlns="http://www.w3.org/2000/svg"
      >
        <path
          fill-rule="evenodd"
          d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
          clip-rule="evenodd"
        >
        </path>
      </svg>
    </button>
    """
  end

  attr(:class, :any, default: nil)
  attr(:nav_items, :list, required: true)

  def sandwich_nav_menu(assigns) do
    ~H"""
    <div
      class="items-center justify-between hidden w-full lg:flex lg:w-auto lg:order-1"
      id="mobile-menu-2"
    >
      <ul class="flex flex-col mt-4 font-medium lg:flex-row lg:space-x-8 lg:mt-0">
        <%= for {label, link, current} <- @nav_items do %>
          <.sandwich_nav_menu_item label={label} link={link} current={current} />
        <% end %>
      </ul>
    </div>
    """
  end

  defp sandwich_nav_items do
    [
      # {"Home", "#", true},
      # {"Marketplace", "#", false},
      # {"Features", "#", false},
      # {"Contact", "#", false}
    ]
  end

  attr(:label, :string, required: true)
  attr(:link, :string, required: true)
  attr(:current, :boolean, default: false)

  def sandwich_nav_menu_item(assigns) do
    ~H"""
    <li>
      <a
        href={@link}
        aria-current={if @current, do: "page", else: "false"}
        class={[
          "block py-2 pl-3 pr-4 lg:p-0",
          if(@current,
            do: "bg-blue-700 text-white lg:bg-transparent dark:text-white rounded",
            else: "text-gray-700 lg:hover:text-blue-700 dark:text-gray-400 dark:hover:text-white"
          ),
          "hover:bg-gray-50 lg:hover:bg-transparent",
          " dark:hover:bg-gray-700 lg:dark:hover:bg-transparent dark:border-gray-700",
          "border-b border-gray-100 lg:border-0"
        ]}
      >
        <%= @label %>
      </a>
    </li>
    """
  end
end
