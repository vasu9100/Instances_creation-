AMI_ID=ami-03265a0778a880afb
SG_ID=sg-0eab7d3878626d44d
INSTANCE_TYPE="t2.micro"
SERVER_NAMES=("web" "catalogue" "cart" "user" "shipping" "payment" "mysql" "rabbitmq" "redis" "dispatch")

for SERVER_NAME in "${SERVER_NAMES[@]}"; do
    INSTANCE_ID=$(aws ec2 run-instances --image-id "$AMI_ID" --instance-type "$INSTANCE_TYPE" --security-group-ids "$SG_ID" --query 'Instances[0].InstanceId' --output text)

    aws ec2 create-tags --resources "$INSTANCE_ID" --tags "Key=Name,Value=$SERVER_NAME"
    
    echo "Instance $SERVER_NAME has been created with ID: $INSTANCE_ID"
done
