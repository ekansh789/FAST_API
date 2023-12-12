#env.sh
#Read the .env.stage file passwd as the first argument 
# and output a valid JSON object with strings for both 
#keys and values

env_file=$1
cat <<EOF
{
$(sed 's/=/": "/g; s/^/"/; s/$/",/' $env_file | sed '$ s/,$//')
}
EOF