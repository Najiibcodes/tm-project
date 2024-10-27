variable "domain_name" {
  type = string
  description = "Primary domain name for the hosted zone"
}

variable "subdomain_name" {
  type = string
  description = "Subdomain for the A record"
}

variable "alb_dns_name" {
  type = string
  description = "DNS name of the Application Load Balancer"
}

variable "alb_zone_id" {
  type = string
  description = "Zone ID of the Application Load Balancer"
}

variable "domain_validation_options" {
  description = "Domain validation options for ACM certificate"
  type        = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))
}

variable "zone_id" {
  description = "Route 53 Zone ID for the domain"
  type        = string
}