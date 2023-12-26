AMI_ID="ami-03265a0778a880afb"
SG_ID="sg-0eab7d3878626d44d"
SERVER_NAMES=("web" "catalogue" "cart" "user" "shipping" "payment" "mysql" "rabbitmq" "redis" "dispatch" "mongodb")
HOSTED_ZONE_ID="Z08382393NBPVIFQUJM1I"

if [ -n "$SERVER_NAMES" ]; then
    echo "Instances already exist. No need to create."
else
    for SERVER_NAME in "${SERVER_NAMES[@]}"; do
        if [ "$SERVER_NAME" == "mysql" ] || [ "$SERVER_NAME" == "shipping" ] || [ "$SERVER_NAME" == "mongodb" ]; then
            INSTANCE_TYPE="t2.medium"
        else
            INSTANCE_TYPE="t2.micro"
        fi

        PRIVATE_IP=$(aws ec2 run-instances \
            --image-id "$AMI_ID" \
            --instance-type "$INSTANCE_TYPE" \
            --security-group-ids "$SG_ID" \
            --query 'Instances[0].PrivateIpAddress' \
            --output text)

        aws ec2 create-tags --resources "$PRIVATE_IP" --tags "Key=Name,Value=$SERVER_NAME"

        echo "Instance $SERVER_NAME has been created with Private IP: $PRIVATE_IP"

         aws route53 change-resource-record-sets \
            --hosted-zone-id "$HOSTED_ZONE_ID" \
            --change-batch "{
              \"Changes\": [
                {
                  \"Action\": \"UPSERT\",
                  \"ResourceRecordSet\": {
                    \"Name\": \"$SERVER_NAME.example.com\",
                    \"Type\": \"A\",
                    \"TTL\": 300,
                    \"ResourceRecords\": [
                      {\"Value\": \"$PRIVATE_IP\"}
                    ]
                  }
                }
              ]
            }"
    done
fi
