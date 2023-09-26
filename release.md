# IMPROVE Release 2023-09-30

This release allows optimizing hyperparameters for machine learning using data provided or described by the original model code creator. It includes instructions for setting up the infrastructure and performing initial HPO. 

Included in this release are:
- Hyper Parameter Optimization (HPO) workflow version v0.6
- IMPROVE models, build and testing code version v0.6.0
- IMPROVE documentation version v0.6.0
- CANDLE library v0.8

## Documentation:

Repository: https://github.com/JDACS4C-IMPROVE/docs
Documentation: https://jdacs4c-improve.github.io/docs/index.html

Release:
- Version: v0.6.0
- URL: https://github.com/JDACS4C-IMPROVE/docs/releases/tag/v0.6.0

New documentation guides for:
- Setting up the initial environment for building support model container images and executing HPO workflow
- Instructions for making container images for supported models
- Instructions for setting up HPO for a supported model

## Build and test framework

Repo: https://github.com/JDACS4C-IMPROVE/Singularity

Release:
- Version: 	v0.6.0
- URL: 	https://github.com/JDACS4C-IMPROVE/Singularity/releases/tag/v0.2-alpha

This release includes:
- build instructions for supported model containers. 
- test scripts for models and containers 

## Workflows

This release of the supervisor supports the Hyper Parameter Optimization Workflow.

Repo: Supervisor

Release:
- Version: v0.6
- URL: 	https://github.com/ECP-CANDLE/Supervisor

## HPO Examples



## CANDLE library

Vendorized version of candle_lib. This version is used by all models and provides a standardized interface for model execution.

Release:
- Version: v0.8.0
- URL: https://github.com/JDACS4C-IMPROVE/candle_lib/releases/tag/v0.8.0

## New supported models:

This models have been modified to provide a standardized interface for model training. 

- GraphDRP 
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/GraphDRP

- DeepTTC
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/DeepTTC

- Paccmann_MCA
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/Paccmann_MCA

- DrugCell
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/DrugCell

- DRPreter
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/DRPreter

- UNO
  - Version: improve
  - URL: https://github.com/ECP-CANDLE/Benchmarks

- HiDRA
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/HiDRA



### Future release candidates

- tCNNS
  - Version: v0.6.0
  - URL: https://github.com/JDACS4C-IMPROVE/tCNNS

- TGSA
  - Version: develop
  - URL: https://github.com/JDACS4C-IMPROVE/TGSA

- DrugGCN
  - Version: improve
  - URL: https://github.com/JDACS4C-IMPROVE/DrugGCN

- IGTD
  - Version: improve
  - URL: https://github.com/JDACS4C-IMPROVE/IGTD

- SWnet
  - Version: improve
  - URL: https://github.com/JDACS4C-IMPROVE/SWnet
