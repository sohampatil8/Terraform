variable username {
        type = string
}
variable age {
        type = number
}

output print {
        value = "hello ${var.username}, my age is ${var.age}"
}