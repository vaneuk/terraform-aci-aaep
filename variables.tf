variable "name" {
  description = "Attachable access entity profile name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "infra_vlan" {
  description = "Infrastructure vlan ID. A vlan ID of `0` disables the infrastructure vlan. Minimum value: 0. Maximum value: 4096."
  type        = number
  default     = 0

  validation {
    condition     = var.infra_vlan >= 0 && var.infra_vlan <= 4096
    error_message = "Minimum value: 0. Maximum value: 4096."
  }
}

variable "physical_domains" {
  description = "Physical domains."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for pd in var.physical_domains : can(regex("^[a-zA-Z0-9_.-]{0,64}$", pd))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "routed_domains" {
  description = "Routed domains."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for rd in var.routed_domains : can(regex("^[a-zA-Z0-9_.-]{0,64}$", rd))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vmware_vmm_domains" {
  description = "VMware VMM domains."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for vmwd in var.vmware_vmm_domains : can(regex("^[a-zA-Z0-9_.-]{0,64}$", vmwd))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "endpoint_groups" {
  description = "List of application endpoint groups. Allowed values `vlan`: `1` - `4096`. Allowed values `primary_vlan`: `1` - `4096`. Default value `primary_vlan`: ``. Choices `mode`: `regular`, `native`, `untagged`. Default value `mode`: `regular`"
  type = list(object({
    tenant              = string
    application_profile = string
    endpoint_group      = string
    vlan                = number
    primary_vlan        = optional(number)
    mode                = optional(string)
  }))
  default = []

  validation {
    condition = alltrue([
      for epg in var.endpoint_groups : can(regex("^[a-zA-Z0-9_.-]{0,64}$", epg.tenant))
    ])
    error_message = "`tenant`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for epg in var.endpoint_groups : can(regex("^[a-zA-Z0-9_.-]{0,64}$", epg.application_profile))
    ])
    error_message = "`application_profile`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for epg in var.endpoint_groups : can(regex("^[a-zA-Z0-9_.-]{0,64}$", epg.endpoint_group))
    ])
    error_message = "`endpoint_group`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for epg in var.endpoint_groups : epg.vlan == null || try(epg.vlan >= 1 && epg.vlan <= 4096, false)
    ])
    error_message = "`vlan`: Minimum value: `1`. Maximum value: `4096`."
  }

  validation {
    condition = alltrue([
      for epg in var.endpoint_groups : epg.primary_vlan == null || try(epg.primary_vlan >= 1 && epg.primary_vlan <= 4096, false)
    ])
    error_message = "`primary_vlan`: Minimum value: `1`. Maximum value: `4096`."
  }

  validation {
    condition = alltrue([
      for epg in var.endpoint_groups : epg.mode == null || try(contains(["regular", "native", "untagged"], epg.mode), false)
    ])
    error_message = "`mode`: Allowed values are `regular`, `native` or `untagged`."
  }
}