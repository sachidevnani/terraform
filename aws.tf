provider "aws" {
  access_key = "##"
  secret_key = "#"
  region     = "us-east-2"
}
resource "aws_instance" "example" {
  ami           = "ami-0653e888ec96eab9b"
  instance_type = "t2.micro"
  key_name      = "hell"

provisioner "remote-exec" {
  inline =[ 
   "cd /opt",
   "sudo wget -O splunk-6.6.8-6c27a8439c1e-Linux-x86_64.tgz 'https://www.splunk.com/page/download_track?file=6.6.8/linux/splunk-6.6.8-6c27a8439c1e-Linux-x86_64.tgz&ac=&wget=true&name=wget&platform=Linux&architecture=x86_64&version=6.6.8&product=splunk&typed=release'",
   "sudo tar xvzf splunk-6.6.8-6c27a8439c1e-Linux-x86_64.tgz",
   "sudo /opt/splunk/bin/splunk start --accept-license --answer-yes",
   "sudo  /opt/splunk/bin/splunk login -auth admin:changeme"
]
}
connection {
  type = "ssh"
  user = "ubuntu"
  password = ""
  private_key = "${file("/home/ubuntu/hell.pem")}"
}
}
