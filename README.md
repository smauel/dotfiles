# dotfiles

## Installing

To install everything:

```bash
./install all
```

For full list of commands available run: 

```bash
./install
```

## Customizations

### Git Author

Create a file in this directory called `~/.gitauthor`

```bash
GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="email@you.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```
