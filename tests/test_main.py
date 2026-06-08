from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


def test_root_returns_200():
    response = client.get("/")
    assert response.status_code == 200


def test_root_message():
    response = client.get("/")
    data = response.json()
    assert "message" in data
    assert "version" in data


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_info_has_pipeline_stages():
    response = client.get("/info")
    assert response.status_code == 200
    data = response.json()
    assert "pipeline_stages" in data
    assert len(data["pipeline_stages"]) == 4