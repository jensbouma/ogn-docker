# Generates a 64-character secret for the tunnel.
resource "random_password" "tunnel_secret" {
  length = 64
}

data "cloudflare_zones" "zone" {
  filter {
    name = local.cloudflare_zone
  }
}

# Creates a new locally-managed tunnel for the GCP VM.
resource "cloudflare_tunnel" "auto_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "${lower(local.receiver_name)}-rpi"
  secret     = base64sha256(random_password.tunnel_secret.result)
}

resource "cloudflare_record" "ssh" {
  zone_id = data.cloudflare_zones.zone.zones.0.id
  name    = "${lower(local.receiver_name)}-ssh.${data.cloudflare_zones.zone.zones.0.name}"
  value   = "${cloudflare_tunnel.auto_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "status" {
  zone_id = data.cloudflare_zones.zone.zones.0.id
  name    = "${lower(local.receiver_name)}-status.${data.cloudflare_zones.zone.zones.0.name}"
  value   = "${cloudflare_tunnel.auto_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}
resource "cloudflare_record" "decoder" {
  zone_id = data.cloudflare_zones.zone.zones.0.id
  name    = "${lower(local.receiver_name)}-decoder.${data.cloudflare_zones.zone.zones.0.name}"
  value   = "${cloudflare_tunnel.auto_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "portainer" {
  zone_id = data.cloudflare_zones.zone.zones.0.id
  name    = "${lower(local.receiver_name)}-portainer.${data.cloudflare_zones.zone.zones.0.name}"
  value   = "${cloudflare_tunnel.auto_tunnel.id}.cfargotunnel.com"
  type    = "CNAME"
  proxied = true
}