resource "aws_route53_zone" "mc_hosted_zone" {
  name = "minecraft.armandoherra.games"
}

resource "aws_route53_record" "mc_ns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "minecraft.armandoherra.games"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.mc_hosted_zone.name_servers
}

resource "aws_route53_record" "a_domain_record" {
  zone_id = aws_route53_zone.mc_hosted_zone.zone_id
  name    = var.server_subdomain_name
  type    = "A"
  ttl     = 60
  records = ["${module.minecraft_server.public_ip}"]
}

resource "aws_route53_record" "srv_domain_record" {
  zone_id = aws_route53_zone.mc_hosted_zone.zone_id
  name    = var.server_subdomain_name
  type    = "SRV"
  ttl     = 60
  records = ["0 100 25565 ${var.server_subdomain_name}"]
}
