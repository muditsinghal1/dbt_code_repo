#GLOBAL SNOWFLAKE connection

resource "dbtcloud_global_connection" "snowflake_global" {
  name = "My Snowflake connection"
  // we can set Privatelink if needed
  #private_link_endpoint_id = data.dbtcloud_privatelink_endpoint.my_private_link.id
  snowflake = {
    account                   = "mq74393.us-east-2.aws.snowflakecomputing.com"
    database                  = "TEST_DB"
    warehouse                 = "COMPUTE_WH"
    client_session_keep_alive = false
    #allow_sso                 = false
    #oauth_client_id           = "yourclientid"
    #oauth_client_secret       = "yourclientsecret"
  }
}

#DEV environment credentials 
resource "dbtcloud_snowflake_credential" "dev_credential" {
  project_id  = dbtcloud_project.tf_test_project.id
  auth_type   = "password"
  num_threads = 4
  schema      = "MODELED"
  user        = "mudit"
  password    = "Welcome$1"
  database    = "test_db"
  role        = "sysadmin"
  warehouse   = "compute_wh"
}

#Building the Environments.
resource "dbtcloud_environment" "development_environment" {
  depends_on    = [dbtcloud_snowflake_credential.dev_credential]
  dbt_version   = "versionless"
  name          = "Development"
  project_id    = dbtcloud_project.tf_test_project.id
  custom_branch = "develop"  
  use_custom_branch = true
  type          = "development"
  connection_id = dbtcloud_global_connection.snowflake_global.id   # Use it If we are using dbtcloud_global_connection(new resource)
}


#Adding gitHub Repo to dbtCloud. This allows you to manage connections to git repositories in dbt Cloud.
resource "dbtcloud_repository" "github_repo" {
  project_id             = dbtcloud_project.tf_test_project.id
  remote_url             = "git@github.com:muditsinghal1/phdata_dbt_test1.git"    #https://github.com/muditsinghal1/phdata_dbt_test1.git  "git@github.com:<github_org>/<github_repo>.git" 
}
# link a dbt Cloud project to a git repository
resource "dbtcloud_project_repository" "dbt_project_repository" {
  project_id    = dbtcloud_project.tf_test_project.id
  repository_id = dbtcloud_repository.github_repo.repository_id
}