#!/bin/bash
account=$1
qos=$2
account_users=$(getent group cades-$1 | awk -F':' '{print $4}' | sed -e 's/,/ /g')

echo "$account: $account_users"
echo
echo "$qos Jobs for $account"
# for edde in ${eddes[@]}
# do
#     qstat -u ${edde}
# done

# for user in ${account_users[@]}
# do
#     qstat -u ${user}
# done

output=$(mdiag -j -v)

# awk portion
read -d '' parseQStats << 'EOF'
BEGIN {
    split(users, Users, / /)
    running = 0;
    tasks = 0;
}
{
    running=$2;
    group=$9;
    tasks=$4;
    job_account=$11;
    this_qos=$5
    user=$9
    echo "$tasks"
    if (running ~ /R/ && job_account == account && this_qos == qos && users ~ user  ) {
            printf("%-10d %3s %5d %12s %12s\\n", $1, user, tasks, $6, $12);  
	    totaltasks += tasks;
    } 
}
END { printf("Current %s Cores Used By %s: %d\\n", qos, account, totaltasks); }
EOF

printf "%-10s %3s %5s %12s %12s\\n" "job" "uid" "proc" "req wall" "queue time"
echo "$output" | awk -v users="${account_users[*]}" -v account="$account" -v qos="$qos" "$parseQStats"
