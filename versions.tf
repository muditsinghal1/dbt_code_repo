terraform   {
    required_providers {
        dbtcloud    =   {
            source  =   "dbt-labs/dbtcloud"
            
            
        }
        aws=   {
            source    = "hashicorp/aws"
            version   = "5.69.0"
        }
    }
}