resource "hcloud_ssh_key" "cedi_ivy" {
  name       = "cedi@ivy"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKQwlVWSGICyOiVryEdEp8bR+ltCxSeikxPTRRgSssL"
}
resource "hcloud_ssh_key" "cedi_ava" {
  name       = "cedi@ava"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC0YM2rlsOXq9OLCMynkPSn6sFkGGOWS9/p5rbcS/OUX"
}
resource "hcloud_ssh_key" "ghaction" {
  name       = "ghaction"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoYpUOVAPNNLTi2sq8pouG2QTrdOccPBKYbPXfdByMz"
}
resource "hcloud_ssh_key" "cedi_liv" {
  name       = "cedi@liv"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBW7KOtsdmhDszm0qaKdtxExNQqNnl6zJLz1vKRmmod2"
}
