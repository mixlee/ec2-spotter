# The config file was created in ondemand_to_spot.sh
export config_file=cn-spot.conf

# Set current dir to working dir - http://stackoverflow.com/a/10348989/277871
cd "$(dirname ${BASH_SOURCE[0]})"

. ../$config_file || exit -1

export instance_id=`aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" \
    "Name=tag:Name,Values=${ec2spotter_hostname}" "Name=availability-zone,Values=${ec2spotter_launch_zone}" \
    "Name=instance-type,Values=${ec2spotter_instance_type}" \
    --query "Reservations[*].Instances[*].InstanceId" --output=text`

if [ x"$instance_id" == "x" ] ; then
    echo "no running specify instance not found, exit!"
    exit 0
fi

echo "Host ${ec2spotter_hostname} will terminate, Instance ID: ${instance_id}"
echo -e "\nInstance Info:"
aws ec2 describe-instances --instance-ids $instance_id --query "Reservations[*].Instances[*]"

# wait seconds:
seconds_left=15
echo "wait ${seconds_left} to terminate instance."
while [ $seconds_left -gt 0 ];do
      echo -n $seconds_left
      sleep 1
      seconds_left=$(($seconds_left - 1))
      echo -ne "\r     \r"
done

# terminate instance:
aws ec2 terminate-instances --instance-ids $instance_id
