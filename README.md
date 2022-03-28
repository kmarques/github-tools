# github-tools

## Steps

### GitHub Token

Go to https://github.com/settings/tokens and create an access token for the account to use.

### Environment

Edit the `.env.local` before running any scripts.

```bash
cp .env .env.local
```

### Create the invitations

Separate the repositories and the usernames with a semi-colon (`;`).

```bash
touch data/invitations
```

```
2021-2022-4iw-group-01;aminnairi
```

### Prepare the repositories

```bash
bash ./repo_generator.sh
```

### Send the invitations

```bash
bash ./repo_invite.sh
```
