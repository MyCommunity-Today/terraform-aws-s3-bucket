# Simple Storage Service (S3) Terraform Module

Terraform module to provision [`Simple Storage Service Service`](https://aws.amazon.com/s3) on AWS.

## Usage

### Simple setup

Create a simple S3 bucket with default configurations.
```hcl
    module "s3" {
        source     = "git@github.com:nclouds/terraform-aws-s3-bucket.git?ref=v0.1.1"
        identifier = var.identifier
        tags       = var.tags
    }
```

For more details on a working example, please visit [`examples/simple`](examples/simple)

### Advanced Setup
If you want to create S3 bucket with enhanced configuration e.g ACLs , force_destory etc. and also objects inside, you can use the module like this:

```hcl
    module "s3" {
        source        = "git@github.com:nclouds/terraform-aws-s3-bucket.git?ref=v0.1.1"
        identifier    = var.identifier
        tags          = var.tags
        force_destroy = "true"
        acl           = "public-read"
    }

    module "file" {
        source      = "git@github.com:nclouds/terraform-aws-s3-bucket.git//modules/s3-object?ref=v0.1.1"
        file_source = "utils/file.txt"
        bucket      = module.s3.output.bucket.id
        tags        = var.tags
        key         = "file.txt"
    }
```

For more options refer to a working example at [`examples/advanced`](examples/advanced)

## Examples
Here are some working examples of using this module:
- [`examples/simple`](examples/simple)
- [`examples/advanced`](examples/advanced)

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| acl | The canned ACL to apply | `string` | `"private"` | no |
| force\_destroy | A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error | `bool` | `false` | no |
| identifier | The name of the security group | `string` | n/a | yes |
| tags | Tags to be applied to the resource | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| output | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing
If you want to contribute to this repository check all the guidelines specified [here](.github/CONTRIBUTING.md) before submitting a new PR.