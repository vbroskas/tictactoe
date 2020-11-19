defmodule TictactoeWeb.GameLiveTest do
  @moduledoc """
  For these tests to all run properly you need to have comp_move_smart enabled in the game_core module (line 109)
  """
  use TictactoeWeb.ConnCase
  import Phoenix.LiveViewTest

  test "display cells", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert view |> element(".grid") |> has_element?()
  end

  test "click cell to mark it", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert view |> element("[phx-value-cell=\"c2\"]") |> render() =~ ""
    refute view |> element("[phx-value-cell=\"c2\"]") |> render() =~ "X"
    assert view |> element("[phx-value-cell=\"c2\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c2\"]") |> render() =~ "X"
    refute view |> element("[phx-value-cell=\"c2\"]") |> render() =~ "O"
  end

  test "endgame modal opens", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    refute view |> element("#game-modal") |> has_element?()
    assert view |> element("[phx-value-cell=\"c3\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c7\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c4\"]") |> render_click()
    assert view |> element("#game-modal") |> has_element?()
  end

  test "computer goes first when button clicked", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert view |> element("[phx-value-cell=\"c1\"]") |> render() =~ ""
    assert view |> element("[phx-click=\"comp_moves_first\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c1\"]") |> render() =~ "O"
  end

  test "human goes first button resets game", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
    assert view |> element("[phx-value-cell=\"c1\"]") |> render() =~ ""
    assert view |> element("[phx-click=\"comp_moves_first\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c1\"]") |> render() =~ "O"
    assert view |> element("[phx-click=\"human_moves_first\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c1\"]") |> render() =~ ""
    assert view |> element("[phx-value-cell=\"c1\"]") |> render_click()
    assert view |> element("[phx-value-cell=\"c1\"]") |> render() =~ "X"
  end
end
