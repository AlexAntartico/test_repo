output "server_public_ip" {
  value = module.minecraft_server.public_ip
}

output "server_instance_id" {
  value = module.minecraft_server.id
}

output "server_ami_id" {
  value = var.ami_id
}

output "server_instance_size" {
  value = var.instance_size
}
