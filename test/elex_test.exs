defmodule ElexTest do
  use ExUnit.Case
  doctest Elex

  test "greets the world" do
    assert Elex.hello() == :world
  end
end
