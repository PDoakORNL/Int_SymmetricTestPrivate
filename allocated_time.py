import re
import subprocess as sp
import shlex
import time

command = "showq -w acct=cnms"
args = shlex.split(command)
cp = sp.run(args, stdout=sp.PIPE)#, encoding='utf-8')
users = {}
lines = cp.stdout.decode('utf-8')
lines = lines.splitlines()
liter = iter(lines)
print(lines)
print("lines:{}",len(lines))
report_line = re.compile(r"^([0-9]+)\s+([a-zA-Z0-9]+)\s+([A-Za-z]+)\s+([0-9]+)\s+([-0-9\:]+)")
try:
    while True:
        line = next(liter)
        if u"eligible" in line or u"blocked" in line:
            break
        match = report_line.search(line)
        if match:
            jobid = match.group(1)
            user = match.group(2)
            procs = match.group(4)
            remaining = match.group(5)
            #sometimes there is a day field
            print(remaining)
            r_fields = [int(r) for r in remaining.split(':')]
            if len(r_fields) > 3:
                days = r_fields.pop(0)
                print(days)
                r_fields[0] += 24 * int(days)
            r_sec = r_fields[0] * 60 * 60 + r_fields[1] * 60 + r_fields[2]
            proc_sec = int(procs) * r_sec
            if user not in users:
                users[user]={}
            users[user][jobid] = proc_sec
except StopIteration:
    pass
maxps=27648000

command = "mdiag -f"
args = shlex.split(command)
cp = sp.run(args, stdout=sp.PIPE, stderr=sp.PIPE)
lines = cp.stdout.decode('utf-8')
lines = lines.splitlines()
fairshares = {}
for user in users:
    for line in lines:
        match = re.match("^{}\s+([0-9\.]+)".format(user), line)
        if match:
            fairshares[user]=match.group(1)
            break
print("{:36}{:>36}".format(" ", "Processor Seconds"))
print("{:12}{:>12}{:>12}{:>24}{:>12}".format("User", "Total Jobs", "fairshare", "allocated", "remaining"))
for user in users:
    allocated_seconds=sum([values for keys,values in users[user].items()])
    remaining_seconds=maxps-allocated_seconds
    print("{:12s}{:>12d}{:>12}{:>24d}{:>12d}".format(user, len(users[user]), fairshares[user], allocated_seconds, remaining_seconds))

            
                
    
    
    
