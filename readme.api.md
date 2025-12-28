
git status && git add . && git commit -m "1.3 initial commit" && git push origin main

----------------------------------------------------------------


GIT Bash
cd /C/Documents/MLOps/E2E_Project/F_All_component_Mlflow

----------------------------------------------------------------

SET WORKING_DIR=C:\MLOps_V2\Prometheus_GITHUB\B1_Create_fastapi_streamlit
cd %WORKING_DIR%

docker network create sentiment-net

docker build -t gceraj/e2e_v1-api:1.1 -f docker\Dockerfile.api .
docker run --name fastapi --network sentiment-net -p 8000:8000 -it gceraj/e2e_v1-api:1.1 bash
uvicorn api.main:app --host 0.0.0.0 --port 8000

docker build -t gceraj/e2e_v1-ui:1.1 -f docker\Dockerfile.ui .
docker run --name streamlit --network sentiment-net -p 8501:8501 -it gceraj/e2e_v1-ui:1.1 bash
# export ENV_API_URL="http://localhost:8000"
# export ENV_API_URL="http://0.0.0.0:8000"
export ENV_API_URL="http://fastapi:8000"
streamlit run ui/app.py --server.port 8501 --server.address 0.0.0.0

docker build -t gceraj/e2e_v1-prom:1.1 -f prometheus\Prom.Dockerfile .
docker run --name prom --network sentiment-net -p 9090:9090 -it gceraj/e2e_v1-prom:1.1

----------------------------------------------------------------

http://localhost:8501/
http://localhost:9090
