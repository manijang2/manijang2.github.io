#!/usr/bin/env bash
#
# Run jekyll serve and then launch the site

set -eu

project_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
cd "$project_dir"

prod=false
command=(bundle exec jekyll s -l)
host="127.0.0.1"

help() {
  echo "Usage:"
  echo
  echo "   bash /path/to/run [options]"
  echo
  echo "Options:"
  echo "     -H, --host [HOST]    Host to bind to."
  echo "     -p, --production     Run Jekyll in 'production' mode."
  echo "     -h, --help           Print this help information."
}

while (($#)); do
  opt="$1"
  case $opt in
  -H | --host)
    if [[ $# -lt 2 || -z $2 ]]; then
      echo "Error: --host requires a host name." >&2
      exit 1
    fi
    host="$2"
    shift 2
    ;;
  -p | --production)
    prod=true
    shift
    ;;
  -h | --help)
    help
    exit 0
    ;;
  *)
    echo -e "> Unknown option: '$opt'\n"
    help
    exit 1
    ;;
  esac
done

command+=(-H "$host")

if $prod; then
  export JEKYLL_ENV=production
fi

if [ -e /proc/1/cgroup ] && grep -q docker /proc/1/cgroup; then
  command+=(--force_polling)
fi

printf '\n> %s\n\n' "${command[*]}"
exec "${command[@]}"
