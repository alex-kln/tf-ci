# TF Github Actions CI Checks

This repo provides a baseline for a github action workflow which runs terraform init, terraform validate, tflint, tfsec, checkov and terraform plan. Additionally with pre-commit it checks for a few hooks to ensure good formatting throughout the repo. The pipeline runs on push to main branch and on pull requests. It also includes a ci file which generates a pre-baked image from a Dockerfile, which is then used in the workflow runs to not download each dependency on every run. **Should be used as a base for further customization.**

---

## Getting Started

Following repo structure is given:
```
PROJECT_XYZ/
└── .github/
    └── workflows/
        └── build-baked-image.yaml
        └── ci.yaml
└── terraform/                      # all tf code inside here
    └── main.tf
    └── .tflint.hcl                 # contains tflint config rules
└── .pre-commit-config.yaml         # runs pre-commit hooks
└── README.md
```

Optional:
If pre-commit is installed run ```pre-commit install``` to install the hooks specified in the config file which run before every commit automatically.

---

## Usage
If want to use pre-baked image:
1. Create the pre-baked image which includes all dependencies, Dockerfile is in this repo. The [github workflow file](.github/workflows/build-baked-image.yaml) generates the image and automatically publishes it to github container registry.
2. Grant this repo read access to this package.
3. Follow instructions below!

Create a repo with above repo structure:
1. Copy this [ci.yaml (if using pre-baked image)](.github/workflows/ci.yaml) or this [ci.yaml (if install dependencies on each run)](./archive/ci.yaml) inside the workflows folder
2. Copy .tflint.hcl config file in root tf directory
3. Optionally install the pre-commit hooks with ```pre-commit install```
4. Push changes to git repo
5. Check the running github action
