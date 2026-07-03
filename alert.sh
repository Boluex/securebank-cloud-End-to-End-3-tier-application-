curl -X POST http://localhost:9093/api/v2/alerts \
  -H "Content-Type: application/json" \
  -d '[{
    "labels": {
      "alertname": "TestAlert",
      "severity": "critical",
      "namespace": "securebank"
    },
    "annotations": {
      "summary": "Test alert - Slack integration working!"
    },
    "startsAt": "'$(date -u +%Y-%m-%dT%H:%M:%SZ)'",
    "endsAt": "'$(date -u -d "+10 minutes" +%Y-%m-%dT%H:%M:%SZ)'"
  }]'
