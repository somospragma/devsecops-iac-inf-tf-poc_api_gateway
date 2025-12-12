resource "aws_route_table" "rt" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route" "dynamic_routes" {
  for_each               = { for idx, route in var.routes : idx => route }
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = each.value.destination_cidr_block

  nat_gateway_id     = lookup(each.value, "nat_gateway_id", null)
  transit_gateway_id = lookup(each.value, "transit_gateway_id", null)
  gateway_id         = lookup(each.value, "gateway_id", null)
  vpc_endpoint_id    = lookup(each.value, "vpc_endpoint_id", null)

}

resource "aws_route_table_association" "rt_association" {
  for_each = { for idx, assoc in var.subnet_ids_and_gateways : idx => assoc }

  subnet_id      = lookup(each.value, "subnet_id", null)
  gateway_id     = lookup(each.value, "gateway_id", null)
  route_table_id = aws_route_table.rt.id
}
