curl -s -X DELETE localhost:9200/movies
curl -s -X PUT localhost:9200/movies -H "Content-Type: application/json" --data-binary @config.json
curl -s -X PUT localhost:9200/movies/_bulk -H "Content-Type: application/x-ndjson" --data-binary @bulk.json