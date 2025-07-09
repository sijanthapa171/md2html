defmodule ElexTest do
  use ExUnit.Case
  doctest Elex

  test "greets the world" do
    assert capture_io(fn -> Elex.hello() end) == "Hello, World!\n"
  end
end 