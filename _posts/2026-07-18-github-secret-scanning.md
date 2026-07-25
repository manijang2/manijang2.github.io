---
title: GitHub Secret Protection (2) - 시크릿 스캐닝
date: 2026-07-18 00:00:00 +0900
categories: [Secure, GitHub]
tags: [Secure, GitHub, secret]     # 소문자 권장
description: GitHub 를 분석한 글
toc: true
math: false
mermaid: false
---

> 이 내용은 Github 공식문서를 참고하여 정리한 글 입니다. <br />
https://docs.github.com/ko/code-security/concepts/secret-security/secret-scanning
{: .prompt-info }

## 1. 시크릿 스캐닝
- 노출된 시크릿을 다른 사용자가 악용하기 전에 자동으로 검색하여 시크릿의 부정 사용을 방지한다.
- 유출된 시크릿은 팀 코드에 대한 무료 평가를 실행할 수 있다.
- 시크릿 스캐닝이 유출된 자격 증명을 탐지하면, 리포지토리의 'Security and quality' 탭에 해당 자격 증명의 상세 정보가 담긴 경고가 생성된다.
- GitHub에 새로운 시크릿 패턴이 추가되면 모든 리포지토리를 다시 검사한다.

### 1) 스캐닝 범위
- 모든 브랜치에 있는 소스코드
- 이슈, 풀 리퀘스트, 토론의 모든(열린, 닫힌) 본문과 댓글
- 위키, 코드조각(gist)

### 2) 시크릿 스캐닝 경고 및 대응
- 시크릿 스캐닝 자격 증명이 유출될 경우 리포지토리의 "Security and quality"항목에 경고가 생성된다.
- 경고가 발생하면 시크릿을 즉시 폐기 후 교체하여 무단 액세스를 방지한다.
```
내가 AWS 키를 퍼블릭 리포에 푸시
        ↓
GitHub이 AKIA... 패턴 감지
        ↓
GitHub → AWS에 직접 통보   ← 나를 거치지 않음
        ↓
AWS가 즉시 그 키를 격리/차단
        ↓
그제야 나는 AWS로부터 "키 유출됐다" 메일 받음
```
- 예를 들어 AWS는 이 통보를 받으면 `AWSCompromisedKeyQuarantine` 정책을 자동으로 붙여서 그 키를 무력화한다.
- 이 자동 통보·격리는 파트너 프로그램에 참여한 서비스에만 적용된다. 사내 시스템, 데이터베이스 접속 정보는 자동 차단 대상이 아니며, 탐지 이후 폐기·교체는 전적으로 본인 몫이다. (단, 경고는 생성)
- 가끔 파트너 서비스에 통보하는 것보다 시크릿 수집 봇이 더 빠를 수 있다.

### 3) 시크릿 스캐닝 사용 조건

#### A. 퍼블릭 리포지토리 (개인 + 조직)
- 시크릿 스캐닝은 자동으로 무료로 실행된다.

#### B. 프라이빗 리포지토리 (조직만)
- GitHub Team/Enterprise Cloud에서 "GitHub Secret Protection"을 구매해야 실행된다.