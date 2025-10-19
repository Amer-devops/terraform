variable "instances" {
 default = ["mongodb" , "catalogue" , "redis"] 
  #  default = {

  #   mongodb = "t3.micro"
  #   catalogue = "t3.micro"
  #   mysql = "t3.small"

  #  }
}

variable "zone_id" {
  default = "Z09921652HC7E9W0W018V"
}

variable "domain_name" {
    default = "daws86s.icu"
  
}