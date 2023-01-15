# Use multi-threading to make requests faster, depending on the threads used and the
# internet connection.

start_time=$(date +%s%3N)

auc_base_url='https://api.hypixel.net/skyblock/auctions?page='
total_pages=60
thread_pool_size=$(grep -c ^processor /proc/cpuinfo)

seq 1 $total_pages | xargs -P $thread_pool_size -I {} bash -c "curl -s -k --compressed -L --connect-timeout 0 --max-time 10 -H 'User-Agent: custom_user_agent' -o /dev/null '$url{}'"
echo 
echo "Runtime: $(($(date +%s%3N)-start_time)) ms"
echo "Threads used for $total_pages pages: $thread_pool_size"
