provider "azurerm" {
  features {}
  subscription_id = "bcd96c64-7593-472e-a7a4-42263462de7a"
}

provider "sysdig" {
  sysdig_secure_url       = "https://secure.sysdig.com"
  sysdig_secure_api_token = "d1c65fe1-fc21-4a86-b465-8347c971da9d"
}
