locals {
  # Convierte la lista de números en un mapa donde la clave es el índice y el valor es el puerto
  ingress_ports_map = { for idx, port in var.ingress_ports_list : idx => port }
}
resource "aws_security_group" "sg" {
  name        = var.sg_name
  description = var.description
  vpc_id      = var.vpc_id

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "ingress_ranges" {
  for_each = { for idx, range in var.port_ranges : idx => range }

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.sg.id
  description       = each.value.name != null ? each.value.name : "Regla de ingreso para el rango ${each.value.from_port} - ${each.value.to_port}"
}

resource "aws_security_group_rule" "ingress_ports_sg" {
  for_each = local.ingress_ports_map

  type              = "ingress"
  from_port         = each.value.from_port
  to_port           = each.value.port
  protocol          = each.value.protocol
  cidr_blocks       = each.value.cidr_blocks
  security_group_id = aws_security_group.sg.id
  description       = each.value.name != null ? each.value.name : "Regla de ingreso para el puerto ${each.value.port}"
}

