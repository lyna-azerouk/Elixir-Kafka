defmodule KafkaXElixirTest do
  use ExUnit.Case
  doctest KafkaXElixir

  test "greets the world" do
    assert KafkaXElixir.hello() == :world
  end
end
