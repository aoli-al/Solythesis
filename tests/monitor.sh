while true; do
  ps  -o %cpu=,%mem=  -p $1
  sleep 0.1
done
