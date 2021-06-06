# Deploying with Docker

On the top root of the directory, there's a Dockerfile which is ready for production build!
If you want to try it locally just run
```
docker build -t ex_platform .
docker run ex_platform
```

Please be aware that ExPlatform requires some environment variables:

```
# run mix phx.gen.secret to get one
SECRET_KEY_BASE="something long"
# The email address which your users will see when receiving an email
SMTP_EMAIL_ADDRESS="hello@example.org"

# The smtp credentials
SMTP_HOST="smtp.example.org"
SMTP_USERNAME="postmaster@example.org"
SMTP_PASSWORD="my_smtp_password"
SMTP_PORT="587"

DATABASE_URL="postgresql://postgres:password@example.org:5738/database_name"
```

# Deployment with Clever Cloud

Please install the Clever CLI first, then you can set the env variables above:

```
clever env set SECRET_KEY_BASE `phx.gen.secret`

# The email address which your users will see when receiving an email
clever env set SMTP_EMAIL_ADDRESS "hello@example.org"

# The smtp credentials
clever env set SMTP_HOST "smtp.example.org"
clever env set SMTP_USERNAME "postmaster@example.org"
clever env set SMTP_PASSWORD "my_smtp_password"
clever env set SMTP_PORT "587"
```

Then connect a Postgres addon and you are set (ExPlatform also works with the default Clever Cloud addon env variables).

