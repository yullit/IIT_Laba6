output "web_instance_public_ip" {
  description = "The public IP of the web server instance"
  value       = aws_instance.web.public_ip
}