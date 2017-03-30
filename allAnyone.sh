#!/bin/bash
account=$1
account_users=$(getent group cades-$1 | awk -F':' '{print $4}' | sed -e 's/,/ /g')

echo $account_users
# for edde in ${eddes[@]}
# do
#     qstat -u ${edde}
# done

for user in ${account_users[@]}
do
    qstat -u ${user}
done

output=$(for user in ${account_users[@]}
	 do
	     qstat -u ${user}
	 done
	 )

# awk portion
read -d '' parseQStats << 'EOF'
BEGIN {
    running = 0;
    tasks = 0;
}
{
    running=$10;
    tasks=$7;
    echo "$tasks"
    if (running ~ /R/) {
	    totaltasks += tasks;
    } 
}
END { printf("Current Cores Used By %s: %d\\n", account, totaltasks); }
EOF


echo "$output" | awk -v account="$account" "$parseQStats"
