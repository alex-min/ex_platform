# Install asdf

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
# Install pre-commit

https://pre-commit.com/

```
pip install pre-commit
pre-commit install
```

