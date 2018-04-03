job "task" {
  datacenters = ["dc1"]
  type = "batch"
  parameterized {
    payload       = "required"
    meta_required = [
      "build_id",
      "user_id",
      "repository",
      "branch",
      "commit",
      "ssh_key"
    ]
  }
  group "tasks" {
    restart {
      attempts = 0
      mode = "fail"
    }
    task "build" {
      driver = "raw_exec"
      env {
        CONFIG_PATH = "${NOMAD_TASK_DIR}/payload.yml"
      }
      config {
        command = "fortress-shell"
      }
      dispatch_payload {
        file = "payload.yml"
      }
    }
  }
}
