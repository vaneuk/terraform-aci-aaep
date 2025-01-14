module "aci_aaep" {
  source  = "netascode/aaep/aci"
  version = ">= 0.0.1"

  name               = "AAEP1"
  infra_vlan         = 10
  physical_domains   = ["PD1"]
  routed_domains     = ["RD1"]
  vmware_vmm_domains = ["VMM1"]
  endpoint_groups = [
    {
      tenant              = "TF"
      application_profile = "AP1"
      endpoint_group      = "EPG1"
      vlan                = "10"
      primary_vlan        = "10"
      mode                = "untagged"
    }
  ]
}
