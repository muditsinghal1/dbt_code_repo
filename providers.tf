provider "dbtcloud" {
    account_id     =   var.DBT_CLOUD_ACCOUNT_ID
    token           =   var.DBT_CLOUD_TOKEN
    host_url        =   var.DBT_CLOUD_HOST_URL

}

#? Need to check why we did not add aws as provider here, why only dbtcloud?

