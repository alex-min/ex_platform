# ExPlatorm, a battery-included battery Phoenix boilerplate!

https://alex-min.fr/open-sourcing-my-phoenix-boilerplate/

What's included out of the box: 
- TailwindCSS with Tailwind jit
- Phoenix auth integrated with nice Tailwind pages and transformed to support i18n
- i18n everywhere (PRs are welcomed to add more languages)
- Notifications with a nice animation and auto-clear
- Auth emails are using Bamboo and proper HTML template
- Javascripts tests with Jest (and I've included some built-in tests)
- Pre-commit checks for styling & dialyzer (this boilerplate is ready for team work)
- Github actions checking the pre-commits and the tests for each commit
- Dependabot
- Asdf integration, just use the .tools-versions for all your versions! It's also what's used in the Github actions. 
- Eslint

Future integrations:
- A pricing page connected to Stripe
- A landing page
- Admin pages
- Mobile view
- ...

Please send a PR if you have some good features you would like to integrate to ExPlatform.

# Setting up the boilerplate
## Install asdf

Please install [asdf](https://asdf-vm.com/#/core-manage-asdf) which can install all the tooling required.

```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
echo '. $HOME/.asdf/asdf.sh' >> ~/.bashrc
```

then restart bash and install all the plugins:

```
asdf plugin-add python
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add nodejs
```

Install all the tools:

```
asdf install
```
## Install pre-commit

https://pre-commit.com/

Pre-commit checks your changes every time you do a commit.

```
pip install pre-commit
pre-commit install
```

## Launching the server

```
mix deps.get
mix ecto.setup
mix phx.server
```

## Tests

```
mix test   # Elixir tests
mix testjs # Javascript tests
```

## updating locales

```
mix gettext.extract
mix gettext.merge priv/gettext/ --locale en
mix gettext.merge priv/gettext/ --locale fr
# ... other locales
```
