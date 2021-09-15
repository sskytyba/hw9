
data='{
  "from": 0,
  "size": 10,
  "query": {
    "match": {
      "'"$1"'.ngram": {
        "query": "'"$2"'",
        "operator": "and"
      }
    }
  }
}'

echo ngram
curl -s -X GET localhost:9200/movies/_search -H "Content-Type: application/json" --data "$data" | jq .hits.hits[]._source."$1"

data='{
  "from": 0,
  "size": 10,
  "query": {
    "multi_match": {
      "type": "phrase_prefix",
      "query": "'"$2"'",
      "fields": [
        "'"$1"'.search_as",
        "'"$1"'.search_as._2gram",
        "'"$1"'.search_as._3gram"
      ]
    }
  }
}'
echo search_as_you_type
curl -s -X GET localhost:9200/movies/_search -H "Content-Type: application/json" --data "$data" | jq .hits.hits[]._source."$1"

data='{
  "from": 0,
  "size": 10,
  "_source": ["suggest"],
  "suggest": {
    "'"$1"'_suggest": {
      "prefix": "'"$2"'",
      "completion": {
        "field": "'"$1"'.suggest",
        "skip_duplicates": true,
        "fuzzy": {
          "fuzziness": 1
        }
      }
    }
  }
}'
echo sugest
curl -s -X GET localhost:9200/movies/_search -H "Content-Type: application/json" --data "$data" | jq .suggest."$1"_suggest[].options[].text



