resource "aws_instance" "web" {
  count = length(var.ec2_names)
  ami           = data.aws_ami.amazon-2.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.sg_id]
  subnet_id = var.subnets[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  user_data = <<-EOF
              #!/bin/bash
              # Update the package manager
              yum update -y

              # Install Apache
              yum install -y httpd

              # Start Apache service
              systemctl start httpd
              systemctl enable httpd

              # Create animated index.html with CSS
              cat <<EOT > /var/www/html/index.html
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta http-equiv="X-UA-Compatible" content="IE=edge">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Welcome</title>
                  <style>
                      body {
                          display: flex;
                          flex-direction: column;
                          justify-content: center;
                          align-items: center;
                          height: 100vh;
                          background-color: #f0f0f0;
                          margin: 0;
                          font-family: Arial, sans-serif;
                          text-align: center;
                      }
                      h1 {
                          font-size: 3em;
                          color: #4CAF50;
                          animation: bounce 2s infinite;
                          margin: 0;
                      }
                      h2 {
                          font-size: 2em;
                          color: #ff5722;
                          animation: fadeIn 4s infinite;
                          margin-top: 10px;
                      }
                      @keyframes bounce {
                          0%, 20%, 50%, 80%, 100% {
                              transform: translateY(0);
                          }
                          40% {
                              transform: translateY(-30px);
                          }
                          60% {
                              transform: translateY(-15px);
                          }
                      }
                      @keyframes fadeIn {
                          0% { opacity: 0; }
                          50% { opacity: 1; }
                          100% { opacity: 0; }
                      }
                  </style>
              </head>
              <body>
                  <h1>Hello Everyone from Terraform Instance ${count.index + 1}!</h1>
                  <h2>Happy Learning!</h2>
              </body>
              </html>
              EOT
              EOF

  tags = {
    Name = var.ec2_names[count.index]
  }
}