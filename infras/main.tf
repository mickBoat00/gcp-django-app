data "google_app_engine_default_service_account" "default" {
  project = "skillful-radar-387911"
}

resource "google_app_engine_flexible_app_version" "myapp_v1" {
  version_id = "v1"
  service    = "default"
  project    = "skillful-radar-387911"
  runtime    = "custom"

  entrypoint {
    shell = "gunicorn -b :8080 main.wsgi"
  }

  deployment {
    container {
      image = "europe-west1-docker.pkg.dev/skillful-radar-387911/my-docker-repo/app-engine-images:latest"
    }
  }

  liveness_check {
    path = "/"
  }

  readiness_check {
    path = "/"
  }

  env_variables = {
    port                             = "8080"
    SECRET_KEY                       = "django-insecure-^n*e$!rizm=^odcbq%nce@%_@k2tt!j0dhvj%+bo&n2ql!2nbi"
    SOCIAL_AUTH_GOOGLE_OAUTH2_KEY    = "493211936327-cd0scp38q47s7i644jf6f1ai773ae59c.apps.googleusercontent.com"
    SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET = "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"
    DATABASE_HOST                    = "10.38.80.3"
    DATABASE_NAME                    = "postgres"
    DATABASE_USER                    = "postgres"
    DATABASE_PASSWORD                = "OBhx=>upP>JsLAhX"
    DATABASE_PORT                    = "5432"
  }

  #   handlers {
  #     url_regex        = ".*\\/my-path\\/*"
  #     security_level   = "SECURE_ALWAYS"
  #     login            = "LOGIN_REQUIRED"
  #     auth_fail_action = "AUTH_FAIL_ACTION_REDIRECT"

  #     static_files {
  #       path              = "my-other-path"
  #       upload_path_regex = ".*\\/my-path\\/*"
  #     }
  #   }

  automatic_scaling {
    cool_down_period = "120s"
    cpu_utilization {
      target_utilization = 0.5
    }
    min_total_instances = 1
    max_total_instances = 1
  }

  noop_on_destroy = true
  service_account = data.google_app_engine_default_service_account.default.email
}


resource "google_app_engine_service_split_traffic" "liveapp" {
  service = google_app_engine_flexible_app_version.myapp_v1.service

  migrate_traffic = true
  split {
    shard_by = "IP"
    allocations = {
      (google_app_engine_standard_app_version.liveapp_v1.version_id) = 1
    }
  }
}


# resource "google_storage_bucket" "bucket" {
#   project  = "skillful-radar-387911"
#   name     = "appengine-static-content"
#   location = "EU"
# }

# resource "google_storage_bucket_object" "object" {
#   name   = "hello-world.zip"
#   bucket = google_storage_bucket.bucket.name
#   source = "./test-fixtures/appengine/hello-world.zip"
# }


