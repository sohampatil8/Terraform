variable officer {
        type = list
        default = ["Mr.SOHAM PATIL(DevOps Engineer), I need Your help" , "Mr. Root" , "Dear sir"]
}

variable Name {
        type = string
}

variable city {
        type = string
}

variable reason {
        type = string
}

output Main-info {
        value = "Hello, ${var.officer [0]}, I am ${var.Name}, I am from ${var.city}, Reason is ${var.reason}"
}