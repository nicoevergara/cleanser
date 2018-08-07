defmodule CleanserTest do
  use ExUnit.Case
  doctest Cleanser

  test "test email validation with default invalid domains" do
    assert Cleanser.validate_email("person@example.com") == :ok
    refute Cleanser.validate_email("person@spambox.me") == {:error, "person@spambox.me is an invalid email"}
  end

  test "test email validation with custom invalid domains" do
    assert Cleanser.validate_email("person@example.com", ["baddomain.com"]) == :ok
    refute Cleanser.validate_email("person@example.com", ["example.com"]) == {:error, "person@example.com is an invalid email"}
  end
end
