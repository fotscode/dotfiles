source ~/.scripts/colors.sh

while IFS=":" read -r a b; do
    case $a in
        "MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
        "Shmem") ((mem_used+=${b/kB}))  ;;
        "MemFree" | "Buffers" | "Cached" | "SReclaimable")
            mem_used="$((mem_used-=${b/kB}))"
            ;;
    esac
done < /proc/meminfo

mem_used="$((mem_used / 1024))"
mem_total="$((mem_total / 1024))"

if [[ -r /proc/uptime ]]; then
    s=$(< /proc/uptime)
    s=${s/.*}
else
    boot=$(date -d"$(uptime -s)" +%s)
    now=$(date +%s)
    s=$((now - boot))
fi

d="$((s / 60 / 60 / 24))d"
h="$((s / 60 / 60 % 24))h"
m="$((s / 60 % 60))m"

battery=`node ~/projects/hyperx/faster.js | head -n 1`

TIME="$BLUE`date +"%d/%m/%Y %H:%M:%S"`$NC"
RAM="$RED RAM:$NC $GREEN${mem_used}MB/${mem_total}MB$NC"
UPTIME="$RED UPTIME:$NC$BLUE ${d} ${h} ${m}$NC"
HEADPHONES="$RED Headphones:$NC $PURPLE${battery}$NC"
SEP="$YELLOW|$NC"

echo -e "$TIME $SEP$RAM $SEP$UPTIME $SEP$HEADPHONES"
