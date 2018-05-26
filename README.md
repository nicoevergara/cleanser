# Cleanser

[![Build Status](https://travis-ci.org/nicoevergara/cleanser.svg?branch=master)](https://travis-ci.org/nicoevergara/cleanser)
[![Hex.pm](https://img.shields.io/hexpm/v/cleanser.svg?style=flat-square)](https://hex.pm/packages/cleanser)
[![Hex.pm](https://img.shields.io/hexpm/dt/cleanser.svg?style=flat-square)](https://hex.pm/packages/cleanser)

A validation library for emails (and more soon!)

## Installation

The package can be installed
by adding `cleanser` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cleanser, "~> 0.1.0"}
  ]
end
```

## Basic Usage

There are three functions that currently exist within Cleanser (with more to come specifically to work with Phoenix's changesets).

```
# Validate email against default invalid domains
Cleanser.validate_email/1

# Validate email against custom invalid domains as well as defaults
Cleanser.validate_email/2

# Validate domain against default invalid domains
Cleanser.is_valid_domain?/1

# Validate domain against custom invalid domains as well as defaults
Cleanser.is_valid_domain?/2

# Validate credit card number using the Luhn algorithm
Cleanser.is_valid_credit_card?/1
```

These functions will return a simple `:ok` or `{:error, "<error_message>"}` if the email/domain/credit card is valid or invalid. If there are any errors with types, standard errors will be thrown, though some guards in there to prevent as many issues as possible.

Documentation can
be found at [https://hexdocs.pm/cleanser](https://hexdocs.pm/cleanser).

If you have any problems with the package or have any feature requests, please create a [GitHub issue](https://github.com/nicoevergara/cleanser/issues) and I'll make sure to check it out!

## Developement

I will be streaming the creation of this library on Twitch!

Feel free to [follow me](https://twitch.tv/floatingdev) on there to watch the development and have the opportunity to give feedback in real-time.

