defmodule Cleanser do
  @moduledoc """
  Documentation for Cleanser.
  """

  @doc """
  Email Validation

  ## Examples

      iex> Cleanser.validate_email("person@example.com")
      :ok

      iex> Cleanser.validate_email("person@spambox.me")
      {:error, "spambox.me is an invalid domain"}

      iex> Cleanser.validate_email("blocked.com")
      {:error, "Unable to get the domain from blocked.com"}

      iex> Cleanser.validate_email("person@example.com", ["example.com"])
      {:error, "example.com is an invalid domain"}

      iex> Cleanser.validate_email("person@example.com", ["abc.com"])
      :ok

  """

  def validate_email(email, invalid_domains \\ []) when is_binary(email) and is_list(invalid_domains) do
    case parse_email_domain(email) do
      {:ok, domain} ->
        is_valid_domain?(domain, invalid_domains)
      {:error, error_message } ->
        {:error, error_message}
    end
  end

  @doc false
  def parse_email_domain(email) when is_binary(email) do
    email_parts = String.split(email, "@")

    case email_parts do
      [_, domain] ->
        {:ok, domain}
      _ ->
        {:error, "Unable to get the domain from #{email}"}
    end
  end

  @doc """
  Domain Validation

  Validated a given `domain` against a list of disposable emails.

  ## Examples

      iex> Cleanser.is_valid_domain?("example.com")
      :ok

      iex> Cleanser.is_valid_domain?("spambox.me")
      {:error, "spambox.me is an invalid domain"}

  It also validates a given `domain` against a list of custom domains.

  ## Example

      iex> Cleanser.is_valid_domain?("example.com", ["example.com"])
      {:error, "example.com is an invalid domain"}

  """

  def is_valid_domain?(domain, invalid_domains \\ []) when is_list(invalid_domains) do
    is_valid = invalid_domains ++ disposable_domains()
              |> MapSet.new
              |> MapSet.member?(domain)
              |> Kernel.not

    case is_valid do
      true ->
        :ok
      false ->
        {:error, "#{domain} is an invalid domain"}
    end
  end

  @doc false
  defp disposable_domains do
    Path.join(:code.priv_dir(:cleanser), "disposable_emails.txt")
    |> File.read!
    |> String.split
  end

  @doc """
  Bad Words Filter

  Validates a string against a list of bad words in the language chosen.

  ## Examples

      iex> Cleanser.contains_bad_words?("Hello I am normal", "English")
      :ok

      iex> Cleanser.contains_bad_words?("What the butt", "english")
      {:error, "This string contains bad words"}

      iex> Cleanser.contains_bad_words?("ok ok 挿入 ok ok", "japanese")
      {:error, "This string contains bad words"}
  """

  def contains_bad_words?(string, language) do
    is_valid_language?(language)
    words = String.downcase(string)
            |>String.split
            |>MapSet.new
    is_valid = bad_words(language)
              |> MapSet.new
              |> MapSet.disjoint?(words)
    case is_valid do
      true ->
        :ok
      false ->
        {:error, "This string contains bad words"}
    end
  end

  defp bad_words(language) do
    Path.join(:code.priv_dir(:cleanser), "bad_words/#{language}.txt")
    |> File.read!
    |> String.downcase()
    |> String.split
  end

  @doc """
  Language Validation

  Validates a language against a list of available languages.

  ## Examples

      iex> Cleanser.is_valid_language?("dutch")
      :ok

      iex> Cleanser.is_valid_language?("Gibberish")
      {:error, "gibberish is either not a valid language or not available in this package"}

  """

  def is_valid_language?(language) do
    language = String.downcase(language)
    valid_language = ["arabic", "chinese", "czech", "danish", "dutch", "english", "esperanto", "finnish", "french",
      "german", "hindi", "hungarian", "italian", "japanese", "korean", "norwegian", "persian", "polish",
      "portuguese", "russian", "spanish", "swedish", "thai", "turkish"]
                    |> MapSet.new
                    |> MapSet.member?(language)

    case valid_language do
      true ->
        :ok
      false ->
        {:error, "#{language} is either not a valid language or not available in this package"}
    end
  end
end
