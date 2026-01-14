package main

# The set of allowed instance types
allowed_types = {"t2.micro", "t3.micro"}

# The logic: Find all AWS instances and check their type
deny[msg] {
  # Find a resource in the terraform plan
  resource := input.resource.aws_instance[name]
  
  # specific logic: check if instance_type is NOT in the allowed list
  not allowed_types[resource.instance_type]

  # The error message to show the developer
  msg = sprintf("Resource '%v' uses instance type '%v'. Only t2.micro or t3.micro are allowed!", [name, resource.instance_type])
}
