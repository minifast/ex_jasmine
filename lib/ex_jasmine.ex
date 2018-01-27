defmodule Jasmine do
  import Plug.Conn

  defmodule Config do
    defstruct js_files: [], jasmine_css: nil, jasmine_js: nil, jasmine_html_js: nil, jasmine_boot_js: nil
  end

  @jasmine_css File.read!(Path.expand("jasmine-2.9.1/jasmine.css", __DIR__))
  @jasmine_js File.read!(Path.expand("jasmine-2.9.1/jasmine.js", __DIR__))
  @jasmine_html_js File.read!(Path.expand("jasmine-2.9.1/jasmine-html.js", __DIR__))
  @jasmine_boot_js File.read!(Path.expand("jasmine-2.9.1/boot.js", __DIR__))
  @template File.read!(Path.expand("run.html.eex", __DIR__))

  def init(js_files: js_files) do
    %Config{
      js_files: js_files,
      jasmine_css: @jasmine_css,
      jasmine_js: @jasmine_js,
      jasmine_html_js: @jasmine_html_js,
      jasmine_boot_js: @jasmine_boot_js
    }
  end
  def init([]), do: init(js_files: [])

  def call(%{request_path: "/jasmine"} = conn, config) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, EEx.eval_string(@template, Map.to_list(config)))
    |> halt
  end

  def call(conn, _), do: conn
end
