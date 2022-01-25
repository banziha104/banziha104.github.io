# Container

<br>

### Containerization & Container Orchestraion

- Containerization : 컨테이너화 하는 기술
  - Container : 격리된 공간에서 프로세스를 실행시킬 수 있는 기술
- Container Orchestration : 컨테이너를 관리하는 기술
- 사용 이유
  - Reproducibility : 실행 환경의 일관성 & 독립성
  - Job Scheduling : 스케줄 관리, 병렬 작업 관리, 유휴 자원 관리
  - Auto-healing & Auto-scaling : 장애 대응, 트래픽 대응 
- Docker
  - Build Once, Run Anyware
  - 설치
    - Mac : https://docs.docker.com/desktop/mac/install/
  - 베이스 이미지 : 유저랜드만 설치된 파일
  - Docker 이미지 : 베이스 이미지에 필요한 프로그램과 라이브러리, 소스를 설치한 뒤 파일을 하나로 만드는 것을 말함
  - 레이어 : 도커는 베이스 이미지와 비교 했을 때, 다른 부분
  - 기본적으로 도커는 git처럼 버전관리가 가능하며, 기존과 다른 레이어만 이미지 처리하고, 베이스 이미지에 더해 사용하는 방식

- 쿠버네티스
  - Master Node  (컨트롤 플레인)
  - etcd : 데이터베이스 역할
  - kube-apiserver : 중앙에서 관리하는 역활(사용자 인증, 통신, 권한 등)
  - kube-scheduler : 스케쥴링, 배치 전략
  - controller-manager : 관련된 리소스(YAML)을 컨트롤하는 역할
  - Worker Node (노드)
      - kubelet : 워커 노드에서 kube-apiserver로 부터 명령을 하달받고 행동 (주로 컨테이너 런타임을 조절)
      - kube-proxy : 통신과 관련된 역할을 함.
  - 쿠버네티스를 관리하는 명령
      - kubeadm : 클러스터를 부트스트랩하는 명령
      - kubelet : 클러스트의 모든 시스템에서 실행되는 구성 요소로, 창 및 컨테이너 시작과 같은 작업을 수행
      - kubectl : 커맨드 라인, 클라이언트 프로그램


<br>

---

### 