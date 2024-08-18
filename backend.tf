terraform { 
  cloud { 
    
    organization = "Terraform-Azure-state-file-project-01" 

    workspaces { 
      name = "shortlet_project" 
    } 
  } 
}