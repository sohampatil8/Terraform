resource "github_repository" "test-terraform" {
  token = "${var.token}"
  name        = "testing-=terraform-repo"
  description = "Testing purpose"
  visibility = "public"

}
