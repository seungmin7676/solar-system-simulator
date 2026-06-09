# 태양계 관측 시뮬레이터

WebGL로 구현한 3D 태양계 시뮬레이션입니다.

## 실행 방법

`solarSystem.html`을 로컬 웹 서버에서 열어 실행합니다.

```bash
# Python 간이 서버 예시
python -m http.server 8000
# 이후 브라우저에서 http://localhost:8000/solarSystem.html 접속
```

## 구성

- `solarSystem.html` — 메인 진입점 (WebGL 렌더링 코드 포함)
- `shaders/` — GLSL 버텍스·프래그먼트 셰이더
  - `planet_vert.glsl` / `planet_frag.glsl` — 행성 셰이더
  - `sun_vert.glsl` / `sun_frag.glsl` — 태양 셰이더
  - `uniform_color_vert.glsl` / `uniform_color_frag.glsl` — 궤도선 셰이더
- `textures/` — 행성 텍스처 (NASA/Solar System Scope 2K 해상도)

## 기술 스택

- WebGL (순수 JavaScript, 외부 라이브러리 없음)
- GLSL ES 셰이더
