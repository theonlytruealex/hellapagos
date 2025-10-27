defmodule MyGameWeb.ErrorJSONTest do
  use MyGameWeb.ConnCase, async: true

  test "renders 404" do
    assert MyGameWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert MyGameWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
