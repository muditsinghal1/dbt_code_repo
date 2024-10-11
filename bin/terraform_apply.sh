#!/bin/bash
set -euo pipefail

#. bin/resolve_auth.sh  #Need to understand what is the purpose of this file

terraform init
terraform validate
terraform plan
terraform apply -input=false -auto-approve