module "first-app-engine" {
  source      = "../../modules/app_engine"
  variable_id = "v2"
  project_id  = "skillful-radar-387911"
  # env_variables = {
  #   "port" : "8080"
  #   "SECRET_KEY" : "django-insecure-^n*e$!rizm=^odcbq%nce@%_@k2tt!j0dhvj%+bo&n2ql!2nbi"
  #   "SOCIAL_AUTH_GOOGLE_OAUTH2_KEY" : "493211936327-cd0scp38q47s7i644jf6f1ai773ae59c.apps.googleusercontent.com"
  #   "SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET" : "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"
  #   "DATABASE_HOST" : "10.38.80.3"
  #   "DATABASE_NAME" : "postgres"
  #   "DATABASE_USER" : "postgres"
  #   "DATABASE_PASSWORD" : "OBhx=>upP>JsLAhX"
  #   "DATABASE_PORT" : "5432"
  # }

  container_image = "europe-west1-docker.pkg.dev/skillful-radar-387911/my-docker-repo/app-engine-images:latest"

}
