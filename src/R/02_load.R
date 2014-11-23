## Load Dependencies
# Bioconductor
required_packages <- c("EBImage")
packagesBioconductor(required_packages, update=update_packages)

# CRAN
required_packages <- c("devEMF", "RSQLite")
packagesCRAN(required_packages, update=update_packages)

# Github
required_packages <- c("visualizeR", "beeplotR", "transformR")
packagesGithub(required_packages, repo_name="greenore",
               proxy_url="webproxy.balgroupit.com", port=3128,
               auth_token="af8bd0071e5aef71efd5aded3aee60ec68f8a41f",
               update=update_packages)

## Clear Workspace
rm(required_packages, update_packages)
