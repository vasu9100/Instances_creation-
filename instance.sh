AMI_iD=ami-03265a0778a880afb
SG_ID=sg-0eab7d3878626d44d
INSTANCE_TYPE="t2.micro"
SERVER_NAMES=("web" "catalogue" "cart" "user" "shipping" "payment" "mysql" "rabbitmq" "redis" "dispatch")

for SERVER_NAME in "${SERVER_NAMES[@]}"; do
    aws ec2 run-instances --image-id ami-03265a0778a880afb --instance-type t2.micro  --security-group-ids sg-0eab7d3878626d44d
    echo "Instances have been created"
done        
