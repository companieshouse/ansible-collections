import json
from argparse import ArgumentParser

parser = ArgumentParser()
parser.add_argument("-c", "--conf",
                    dest="conf_file_location",
                    help="Source config file, defaults to /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json",
                    default="/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json")
parser.add_argument("-l", "--log-files",
                    dest="new_log_files",
                    nargs="*",
                    help="List of new log files to configure for Cloudwatch Agent",
                    default=[])
parser.add_argument("-g", "--log-group-name",
                    dest="log_group_name",
                    help="Log group name to set for all existing and new logs in Cloudwatch Agent",
                    default="catchall")
parser.add_argument("-o", "--output-file",
                    dest="output_file",
                    help="Output file path for generated file. If not specified will write to stdout.")

args = parser.parse_args()

conf_file_location = args.conf_file_location
new_log_files = args.new_log_files
log_group_name = args.log_group_name
output_file = args.output_file

# Read existing config file into memory
with open(conf_file_location, 'r') as conf_file:
    conf = json.load(conf_file)

# Edit existing log entries with log_group
for log in conf['logs']['logs_collected']['files']['collect_list']:
    log['log_group_name'] = log_group_name


# Construct new log entry for each new log passed and append
for newlog in new_log_files:
    new_conf = dict(
        {
            "file_path": newlog,
            "log_group_name": log_group_name,
            "log_stream_name": "{instance_id}_{hostname}_" + newlog,
            "timezone": "Local"
        }
    )
    conf['logs']['logs_collected']['files']['collect_list'].append(new_conf)


# Output
if output_file:
    with open(output_file, 'w') as jsonfile:
        json.dump(conf, jsonfile, indent=4)
else:
    print(json.dumps(conf, indent=4))
