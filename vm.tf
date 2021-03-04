resource "ah_cloud_server" "srv-1" {
  name = "otus-lab-1"
  datacenter = var.ah_datacenter
  image = var.ah_image_type
  product = var.ah_server_type
  ssh_keys = ["02:84:8c:29:4d:16:10:12:3e:7e:48:fc:d4:46:d8:81"]
  create_public_ip_address = "true"

  /* If you will get error with "local-exec" please uncomment the block "remote-exec" below to make sure that the "local-exec" will reach our newly created VM
  
  provisioner "remote-exec" {
    inline = ["sudo yum update -y"]
  
    connection {
      type = "ssh"
      host = ah_cloud_server.srv-1.ips.0.ip_address
      user = "adminroot"
      private_key = "${file(var.ssh_key_private)}"
    }
  }
  
  */

  provisioner "local-exec" {
    command = "ansible-playbook -u adminroot -i '${ah_cloud_server.srv-1.ips.0.ip_address},' --private-key ${var.ssh_key_private} ansible_provision.yml"
  }
}
