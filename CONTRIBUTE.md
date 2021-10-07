# General

- Use **conventional commits** | https://www.conventionalcommits.org/en/v1.0.0
  - Current suggested **scopes** to be used within feat(scope), fix(scope), ...
    - threat
    - bench
    - scan
    - docs
- Maintain example **diagrams** for a better understanding of the architecture and Sysdig secure resources
  - example diagram-as-code | https://github.com/sysdiglabs/terraform-aws-secure-for-cloud/blob/master/examples/single-account/diagram-single.py
  - resulting diagram | https://github.com/sysdiglabs/terraform-aws-secure-for-cloud/blob/master/examples/single-account/diagram-single.png
- Utilities
  - Useful Terraform development guides | https://www.terraform-best-practices.com


---
# Pull Request

## 1. Check::Pre-Commit

Technical validation for terraform **lint**, **validation**, and **documentation**

We're using **pre-commit** |  https://pre-commit.com
  - Defined in `/.pre-commit-config.yaml`
  - custom configuration | https://github.com/sysdiglabs/terraform-google-secure-for-cloud/blob/master/.pre-commit-config.yaml
  - current `terraform-docs` requires developer to create `README.md` file, with the enclosure tags for docs to insert the automated content
  ```markdown
  <!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
  <!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
  ```

## 2. Check::Integration tests

Final user validation. Checks that the snippets for the usage, stated in the official Sysdig Terraform Registry, are working correctly.

Implemented vía **Terraform Kitchen** | https://newcontext-oss.github.io/kitchen-terraform

- Defined in `/.github/workflows/ci-integration-test.yaml`.

### Kitchen

- Kitchen configuration can be found in `/.kitchen.yml`
- Under `/test/fixtures` you can find the targets that will be tested. Please keep this as similar as possible to the Terraform Registry Modules examples.

**Running Kitchen tests locally**

Ruby 2.7 is required to launch the tests.
Run `bundle install` to get kitchen-terraform bundle.
GCP project and AWS credentials should be configured locally.
```shell
# launch the tests, in other words, it will run `terraform apply`
$ bundle exec kitchen converge

# will destroy test infrastructure, in short, it will run `terraform destroy`
$ bundle exec kitchen destroy

# run all the workflow. In first place, it will run an `apply`. Then, if and only if the `apply` works it will destroy the infrastructure.
$ bundle exec kitchen tests

```




### Terraform Backend

Because CI/CD sometimes fail, we setup the Terraform state to be handled in backend within the AWS `draios-demo` env
- S3 bucket `kitchen-terraform` 
- Dynamo-DB table `kitchen_test` (eu-west-3)

In order to be able to use this terraform backend aws credentials are configured as Github project secret


### Deployed infrastructure resources (consolidation WIP)

We are running this tests in a personal account until we get access to **draios** GCP projects.


---
# Release

- Use **semver** for releases https://semver.org
- Module official releases will be published at terraform registry
- Just create a tag/release and it will be  fetched by pre-configured webhook and published into.
  - For internal usage, TAGs can be used
  - For official verions, RELEASEs will be used, with its corresponding changelog description.
