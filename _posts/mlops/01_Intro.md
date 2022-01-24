# ML Ops

### ML Ops가 필요할 때

  - 학습 환경과 배포 환경을 분리
  - 다양한 OS, 아키텍쳐 등을 분리하기 위해 필요 

<br>

--- 

### 재래식과 DevOps간 비교

- 재래식 
  - 코드 구현 -> 빌드 -> 배포
- DevOps
  - 소프트웨어 구현 -> 빌드 자동화 -> 테스트 자동화 -> 배포 -> 운영 
  - 버전 관리
    - 데이터 버전 관리
    - 모델 버전 관리
  - 테스트 자동화
    - 모델 학습 자동화
    - 모델 성능 평가 자동화
  - 모니터링
    - 서빙 모델 모니터링
    - 데이터 변화 모니터링
    - 시스템 안정성 모니터링 

<br>

--- 

### AI 서비스와 일반 SW와의 차이점

- Data의 차이가 존재
- MLOps = ML + DevOps 

<br>

---

### MLOps 구성요소 


- 데이터
  - 데이터 수집 및 파이프라인 : Sqoop, Flume, Kafka, Flink, Spark Streaming, Airflow
  - 데이터 저장 : MySQL, Hadoop, Amazon S3, MiniO
  - 데이터 관리 : TFDV, DVc, Feast, Amundsen
- 모델
  - 모델 개발 : Jupyter Hub, Docker , Kubeflow, Optuna, Ray, katib
  - 모델 버전 관리 : Git, MLflow, Github Action, Jenkins
  - 모델 학습 스케줄링 관리 : Grafana, Kubernetes
- 서빙 
  - 모델 패키징 : Docker, Flask, FaskAPI, BentoML, Kubeflow, TFServing, seldon-core
  - 서빙 모니터링 : Prometheus, Grafana, Thanos
  - 파이프라인 매니징 : Kubeflow, argo workflows, Airflow
- 프레임워크
  - Amazon SageMaker
  - GCP Vertex AI
  - Azure Machine Learning
  - 