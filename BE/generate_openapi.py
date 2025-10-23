import requests, json

res = requests.get("http://127.0.0.1:8082/api/v1/openapi.json")
with open("openapi.json", "w") as f:
    json.dump(res.json(), f, indent=2)

print("✅ Saved openapi.json")