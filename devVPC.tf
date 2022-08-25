module "customvpc" {
  source = "./Custommodules/customvpc"
  region = var.region
  cidr_blocks = "0.0.0.0/0"
  vpc_cidr_block = "10.0.1.0/24"
  public_cidr = "10.0.1.0/28"
  private_cidr = "10.0.1.16/28"
}