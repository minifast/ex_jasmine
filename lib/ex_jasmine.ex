defmodule Jasmine do
  import Plug.Conn

  defmodule Config do
    defstruct js_files: [], css_files: []
  end

  @template File.read!(Path.expand("run.html.eex", __DIR__))

  def init(js_files: js_files, css_files: css_files) do
    %Config{js_files: js_files, css_files: css_files}
  end
  def init(js_files: js_files), do: init(js_files: js_files, css_files: [])
  def init(css_files: css_files), do: init(js_files: [], css_files: css_files)
  def init([]), do: init(js_files: [], css_files: [])

  def call(%{request_path: "/jasmine"} = conn, config) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, EEx.eval_string(@template, Map.to_list(config)))
    |> halt
  end

  def call(conn, _), do: conn
end
