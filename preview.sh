#!/usr/bin/env bash
#
# 로컬 미리보기 서버 실행 스크립트
#   - Homebrew ruby@3.4를 PATH 앞에 두어 시스템 ruby(2.6) 대신 사용
#   - jekyll serve: LiveReload(-l) + 미래 날짜 글(--future) 포함
#
# 사용법:
#   ./preview.sh              # http://127.0.0.1:4000 에서 미리보기
#   ./preview.sh -H 0.0.0.0   # 같은 네트워크의 다른 기기에서 접속
#   ./preview.sh -p           # production 모드로 빌드/서빙

set -euo pipefail

# 스크립트 위치 = 저장소 루트로 이동
cd "$(dirname "$0")"

# ruby@3.4를 PATH 앞에 추가 (설치돼 있지 않으면 안내)
RUBY_PREFIX="/opt/homebrew/opt/ruby@3.4"
if [ ! -x "$RUBY_PREFIX/bin/ruby" ]; then
  echo "> ruby@3.4 를 찾을 수 없습니다. 먼저 설치하세요:" >&2
  echo "    brew install ruby@3.4" >&2
  exit 1
fi
export PATH="$RUBY_PREFIX/bin:$PATH"

host="127.0.0.1"
prod=false

help() {
  echo "Usage:"
  echo
  echo "   ./preview.sh [options]"
  echo
  echo "Options:"
  echo "     -H, --host [HOST]    바인딩할 호스트 (기본: 127.0.0.1)"
  echo "     -p, --production     production 모드로 실행"
  echo "     -h, --help           도움말 출력"
}

while (($#)); do
  case "$1" in
  -H | --host)
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
    echo -e "> 알 수 없는 옵션: '$1'\n" >&2
    help
    exit 1
    ;;
  esac
done

# 의존성(gem)이 없으면 자동 설치
if ! bundle check >/dev/null 2>&1; then
  echo "> 의존성 설치 중: bundle install"
  bundle install
fi

# eval 없이 직접 실행 ("$host"를 인용해 셸 주입 방지)
echo
if $prod; then
  echo "> JEKYLL_ENV=production bundle exec jekyll serve -l --future -H $host"
  echo
  JEKYLL_ENV=production bundle exec jekyll serve -l --future -H "$host"
else
  echo "> bundle exec jekyll serve -l --future -H $host"
  echo
  bundle exec jekyll serve -l --future -H "$host"
fi
