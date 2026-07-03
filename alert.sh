curl -X POST http://localhost:9093/api/v2/alerts \
  -H "Content-Type: application/json" \
  -d '[{
    "labels": {
      "alertname": "TestAlert",
      "severity": "critical",
      "namespace": "securebank"
    },
    "annotations": {
      "summary": "Test alert from SecureBank",
      "description": "This is a test alert to verify Slack integration"
    }
  }]'
