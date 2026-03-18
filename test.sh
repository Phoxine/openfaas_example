for i in {1..500}; do
  curl -s -u admin:admin \
  -X POST \
  http://127.0.0.1:8080/async-function/echo \
  -d "test" &
done
wait