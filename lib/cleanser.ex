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

  defp disposable_domains do
    Path.join(:code.priv_dir(:cleanser), "disposable_emails.txt")
    |> File.read!
    |> String.split
  end
end
