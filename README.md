# Cleanser

A validation library for emails (and more soon!)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cleanser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cleanser, "~> 0.1.0"}
  ]
end
```

## Basic Usage

There are two functions that currently exist within Cleanser (with more to come specifically to work with Phoenix's changesets).

```
# Validate email with default invalid domains
Cleanser.validate_email/1

# Validate email with custom invalid domains
Cleanser.validate_email/2

# Validate domain against invalid domains
Cleanser.is_valid_domain?/1

# Validate domain against custom invalid domains
Cleanser.is_valid_domain?/2
```

These functions will return a simple `:ok` or `{:error, "<error_message>"}` if the email/domain is valid. If there are any errors with types, standard errors will be thrown.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cleanser](https://hexdocs.pm/cleanser).

