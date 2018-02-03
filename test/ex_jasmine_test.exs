defmodule JasmineTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Jasmine.init([])

  describe "init/0" do
    test "returns a default configuration with no js files" do
      assert Jasmine.init([]).js_files == []
    end

    test "returns a default configuration with no css files" do
      assert Jasmine.init([]).css_files == []
    end
  end

  describe "init/1" do
    test "overrides the javascript files" do
      assert Jasmine.init(js_files: "ok").js_files == "ok"
    end

    test "overrides the css files" do
      assert Jasmine.init(css_files: "ok").css_files == "ok"
    end
  end

  describe "call/2 without the path" do
    test "returns the original conn" do
      conn = conn(:get, "/ham")

      response = Jasmine.call(conn, @opts)

      assert response === conn
    end
  end

  describe "call/2 with the path" do
    test "succeeds" do
      conn = conn(:get, "/jasmine")

      response = Jasmine.call(conn, @opts)

      assert response.status == 200
    end

    test "halts the request" do
      conn = conn(:get, "/jasmine")

      response = Jasmine.call(conn, @opts)

      assert response.halted == true
    end

    test "sends the response" do
      conn = conn(:get, "/jasmine")

      response = Jasmine.call(conn, @opts)

      assert response.state == :sent
    end

    test "renders the jasmine runner" do
      conn = conn(:get, "/jasmine")

      response = Jasmine.call(conn, @opts)

      assert response.resp_body =~ ~r(Jasmine)
    end

    test "renders html" do
      conn = conn(:get, "/jasmine")

      response = Jasmine.call(conn, @opts)

      assert {"content-type", "text/html; charset=utf-8"} in response.resp_headers
    end
  end
end
