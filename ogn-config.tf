output "ogn-config" {
  value = templatefile("${path.module}/templates/ogn-config.tpl", {
    latitude = local.latitude,
    longitude = local.longitude,
    altitude = local.altitude,
    callsign = local.receiver_name
  })  
}