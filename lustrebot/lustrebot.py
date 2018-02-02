import os
import time
import timeit
import shlex
import re
import subprocess as sp
from slackclient import SlackClient

# starterbot's ID as an environment variable
BOT_ID = os.environ.get("BOT_ID")

# constants
AT_BOT = "<@" + BOT_ID + ">"
EXAMPLE_COMMAND = "do"
SLOW_COMMAND = "slow"

# instantiate Slack & Twilio clients
slack_client = SlackClient(os.environ.get('SLACK_BOT_TOKEN'))



def ls_delay(path,max_delay=20):
    args = shlex.split(" ".join(["ls",
                            "-ltr",
                            path]))
    pstdout = open("{}.stdout".format(time.ctime()),'w')
    pstderr = open("{}.stderr".format(time.ctime()),'w')

    start = time.clock()
    process = sp.Popen(args,
                       stdout=pstdout,
                       stderr=pstderr)
    process.pstdout = pstdout
    process.pstderr = pstderr

    while process.poll() is None:
        if max_delay < (time.clock() - start):
            time.sleep(0.001)
            return None
    return time.clock() - start

def handle_command(command, channel):
    """
        Receives commands directed at the bot and determines if they
        are valid commands. If so, then acts on the commands. If not,
        returns back what it needs for clarification.
    """
    reponse = "command not found"
    if command.startswith(SLOW_COMMAND):
        match = re.search(r"(/lustre/.*/[A-Za-z_0-9]*)",command)
        if match is not None:
            dir = match.group(1)
        else:
            dir = "/lustre/pfs1/cades-cnms/epd/QE_surfaces"
        print dir
        ls_return = ls_delay(dir)
        if ls_return is None:
            response = "ls on lustre is crawling, did not return in {} seconds.".format(20)
        else:
            response = "ls is reasonable on lustre, returned in {:0.3f} seconds.".format(ls_return)

    slack_client.api_call("chat.postMessage", channel=channel,
                          text=response, as_user=True)

def parse_slack_output(slack_rtm_output):
    """
        The Slack Real Time Messaging API is an events firehose.
        this parsing function returns None unless a message is
        directed at the Bot, based on its ID.
    """
    output_list = slack_rtm_output
    if output_list and len(output_list) > 0:
        for output in output_list:
            if output and 'text' in output and AT_BOT in output['text']:
                # return text after the @ mention, whitespace removed
                return output['text'].split(AT_BOT)[1].strip().lower(), \
                       output['channel']
    return None, None


if __name__ == "__main__":
    READ_WEBSOCKET_DELAY = 1 # 1 second delay between reading from firehose
    if slack_client.rtm_connect():
        print("LustreBot connected and running!")
        while True:
            command, channel = parse_slack_output(slack_client.rtm_read())
            if command and channel:
                handle_command(command, channel)
            time.sleep(READ_WEBSOCKET_DELAY)
    else:
        print("Connection failed. Invalid Slack token or bot ID?")

