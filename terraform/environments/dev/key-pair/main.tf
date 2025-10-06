module "key_pair" {
  source      = "../../../modules/key-pair"
  environment = "dev"
  name        = "dev-keypair"
  key_save_path = "./keys/dev"
  tags        = var.tags
}
