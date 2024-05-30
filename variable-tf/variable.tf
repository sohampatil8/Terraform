variable work-address {
        type = string
}
variable role {
        type = string
}

output info {
        value = "My office address is ${var.work-address}, my role is ${var.role}"
}