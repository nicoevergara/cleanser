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

  test "test bad language validation" do
    assert Cleanser.is_valid_language?("Arabic") == :ok
    assert Cleanser.is_valid_language?("japanese") == :ok
    assert Cleanser.is_valid_language?("meow") == {:error, "meow is either not a valid language or not available in this package"}
  end

  test "test bad words filter" do
    assert Cleanser.contains_bad_words?("me and fils de pute okwhatthe", "german") == :ok
    assert Cleanser.contains_bad_words?("Puta pinche madre", "Spanish") == {:error, "This string contains bad words"}
    assert Cleanser.contains_bad_words?("me and fils de pute okwhatthe", "french") == {:error, "This string contains bad words"}
    assert Cleanser.contains_bad_words?("ดอกทอง ตอแหล ูด น้ําแตก", "Thai") == {:error, "This string contains bad words"}
  end
end
