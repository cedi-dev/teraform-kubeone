resource "hcloud_ssh_key" "cedi_mae" {
  name       = "cedi@mae"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOO9DMiwRjCCWvMA9TKYxRApgQx3g+owxkq9jy1YyjGN cedi@mae"
}
resource "hcloud_ssh_key" "cedi_ivy" {
  name       = "cedi@ivy"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKKQwlVWSGICyOiVryEdEp8bR+ltCxSeikxPTRRgSssL"
}
resource "hcloud_ssh_key" "ghaction" {
  name       = "ghaction"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKoYpUOVAPNNLTi2sq8pouG2QTrdOccPBKYbPXfdByMz"
}
resource "hcloud_ssh_key" "cedi_devpi" {
  name       = "cedi@devpi"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFd4lpqMI7I9fPboMNhGzVrel0cir3D7bHLHADqE1Kmf"
}
