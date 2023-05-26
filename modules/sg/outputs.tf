output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
}
output "ssh_access" {
  value = aws_security_group.ssh_security_group.id
}
output "ec2_security_group_id" {
  value = aws_security_group.ec2_security_group.id
}