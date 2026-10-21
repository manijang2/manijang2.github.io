# Chirpy Starter

[![Gem Version](https://img.shields.io/gem/v/jekyll-theme-chirpy)][gem]&nbsp;
[![GitHub license](https://img.shields.io/github/license/cotes2020/chirpy-starter.svg?color=blue)][mit]

A minimal, ready-to-use template for creating a blog with the [**Chirpy**][chirpy] Jekyll theme. Get up and running in minutes with all critical files pre-configured.

## Why This Starter Exists

When installing Chirpy through [RubyGems.org][gem], Jekyll can only read a subset of theme files (`_data`, `_layouts`, `_includes`, `_sass`, `assets`) and limited `_config.yml` options from the gem. As a result, users cannot enjoy the full out-of-the-box experience that Chirpy offers.

To unlock all features, the following files must be present in your Jekyll site:

```shell
.
├── _config.yml
├── _plugins
├── _tabs
└── index.html
```

This starter bundles those files from the latest **Chirpy** release along with a [CD][CD] workflow, so you can start writing immediately.

## Usage

Check out the [theme's docs](https://github.com/cotes2020/jekyll-theme-chirpy/wiki).

### 로컬 테스트 환경

Ruby 3.4와 Bundler가 필요합니다. 프로젝트 폴더에서 처음 한 번 다음 명령어를 실행합니다.

```shell
# 테마의 정적 파일을 내려받습니다.
git submodule update --init --recursive

# Ruby 패키지를 프로젝트 내부에 설치합니다.
bundle config set --local path vendor/bundle
bundle install
```

다음 명령어로 미리보기 서버를 실행한 뒤, 브라우저에서 <http://127.0.0.1:4000>에 접속합니다.
파일을 저장하면 블로그를 다시 빌드하고 브라우저를 새로고침합니다.
서버를 종료하려면 터미널에서 `Ctrl+C`를 누릅니다.

```shell
bash tools/run.sh
```

`tools` 폴더에 있는 경우에는 `bash run.sh`로 실행해도 프로젝트 설정을 읽습니다.

다른 터미널에서 미리보기 서버를 종료하려면 다음 명령어를 실행합니다.
이 프로젝트에서 실행한 Jekyll 서버만 종료하며, 4000번 포트를 사용하는 다른 프로그램은 종료하지 않습니다.

```shell
bash tools/stop.sh
```

`_config.yml`을 변경한 경우에는 서버를 종료한 뒤 다시 실행합니다.

```shell
bash tools/stop.sh
bash tools/run.sh
```

배포용 빌드와 생성된 HTML의 내부 링크·이미지·스크립트 검사는 다음 명령어로 실행합니다.
외부 사이트 링크는 검사하지 않습니다. 서버를 종료한 뒤 실행하면 같은 출력 폴더를 함께 사용하는 일을 피할 수 있습니다.

```shell
bash tools/test.sh
```

설치한 패키지와 빌드 결과는 Git에서 제외됩니다. `_config.yml`을 변경한 경우에는 미리보기 서버를 다시 실행합니다.

## Contributing

This repository is automatically updated with new releases from the theme repository. If you encounter any issues or want to contribute to its improvement, please visit the [theme repository][chirpy] to provide feedback.

## License

This work is published under [MIT][mit] License.

[gem]: https://rubygems.org/gems/jekyll-theme-chirpy
[chirpy]: https://github.com/cotes2020/jekyll-theme-chirpy/
[CD]: https://en.wikipedia.org/wiki/Continuous_deployment
[mit]: https://github.com/cotes2020/chirpy-starter/blob/master/LICENSE
