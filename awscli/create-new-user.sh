aws iam create-user --user-name summit-user
credentials=$(aws iam create-access-key --user-name summit-user \
  --query 'AccessKey.[AccessKeyId,SecretAccessKey]' \
  --output text)
access_key_id=$(echo $credentials |cut -d' '  -f1)
secret_access_key=$(echo $credentials |cut -d' '  -f2)
aws configure set profile.summit.aws_access_key_id "$access_key_id"
aws configure set profile.summit.aws_secret_access_key "$secret_access_key"
