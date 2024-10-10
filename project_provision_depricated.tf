#With connections (and later, repositories), it’s necessary to associate them with the dbt Cloud project also, to do this we must specify a counterpart resource to the one above, like this:
#Associating snowflake dev_credential connection to dev environment
resource "dbtcloud_project_connection" "tf_test_project_snowflake_connection" {
  project_id    = dbtcloud_project.tf_test_project.id
  connection_id = dbtcloud_global_connection.snowflake_global.id
}

#Making DEPENDENCIES FOR ENV specific credentails with SNOWFLAKE GLOBAL FOR the PROJECT 
/*resource "dbtcloud_project_connection" "project_connection" {
  depends_on = [dbtcloud_global_connection.snowflake_global]
  project_id    = dbtcloud_project.tf_test_project.id
  connection_id = dbtcloud_global_connection.snowflake_global.id
}*/

# The above resource "dbtcloud_project_connection" is deprecated with the release of global connections and it will be removed in a future version of the provider. Going forward, please set the `connection_id` in the `dbtcloud_environment` resource instead.