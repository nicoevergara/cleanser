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

  test "test credit card validation with invalid card numbers" do
    assert Cleanser.is_valid_credit_card?(4532004657698632172) == :ok
    assert Cleanser.is_valid_credit_card?(370177727770444) == {:error, "370177727770444 is an invalid credit card number"}
  end

end
