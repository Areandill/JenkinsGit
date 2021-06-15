variable "region" {
    description = "Instance Region"
    type = string
    default = "eu-central-1"
}
variable "access_key" {
       description = "Access Key"    
}
variable "secret_key" {
       description = "Secret Key"
}
variable "ami" {
    description = "ami image for instance"
    default = "ami-05f7491af5eef733a"
}
variable "security_groups" {
    description = "EC2 Security group"
    default = ["Apache"]
}
variable "key_name" {
    description = "Existing Instance private Key"
    default = "EC2 Tutorial"
}
