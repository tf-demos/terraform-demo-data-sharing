output "vm_security_group" {
  description = "The security group name for compute instances."
  value       = aws_security_group.allow_web_traffic.name
  sensitive   = false
}

output "vpc_id" {
  description = "The VPC ID."
  value       = aws_vpc.demo.id
  sensitive   = false
}




