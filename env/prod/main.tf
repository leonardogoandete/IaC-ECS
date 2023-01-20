module "prod" {
  source            =   "../../infra"
  nome_repositorio  =   "producao" 
  cargoIAM          =   "producao"
}

output "IP_alb" {
  value = module.prod.IP
}