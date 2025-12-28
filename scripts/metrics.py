from prometheus_client import Counter, generate_latest
from fastapi.responses import Response

# Define metrics
REQUEST_COUNT = Counter("api_requests_total", "Total API requests")

# Metrics endpoint
def metrics_endpoint():
    return Response(generate_latest(), media_type="text/plain")
