<!-- BEGIN_TF_DOCS -->
# AAEP Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

```hcl
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

```
<!-- END_TF_DOCS -->