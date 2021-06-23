#vpc resources
module "network" {
  source = "./modules/vpc-resources"
  region = var.region
  environment = var.environment_tag
}

module "s3-resources" {
  source = "./modules/s3-resource"
  bucket = var.bucket
}


#Pipeline resources
#codepipeline IAM role 
resource "aws_iam_role" "flaskapp_pipeline_role" {
  name = "flaskapp_pipeline_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "codepipeline.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tag
  }

resource "aws_iam_role_policy" "codepipeline_policy" {
  name = "codepipeline_policy"
  role = aws_iam_role.flaskapp_pipeline_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect":"Allow",
      "Action": [
        "s3:GetObject",
        "s3:GetObjectVersion",
        "s3:GetBucketVersioning",
        "s3:PutObjectAcl",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.codepipeline_bucket.arn}",
        "${aws_s3_bucket.codepipeline_bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "codestar-connections:UseConnection"
      ],
      "Resource": "${aws_codestarconnections_connection.example.arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "codebuild:BatchGetBuilds",
        "codebuild:StartBuild"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}
resource "aws_codepipeline" "flaskapp_pipeline" {
  name     = "flask-app-pipeline"
  role_arn = aws_iam_role.flaskapp_pipeline_role.arn
  tags     = {}

  artifact_store {
    location = var.artifacts_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      category = "Source"
      configuration = {
        "BranchName"           = var.repository_branch
        "PollForSourceChanges" = "false"
        "RepositoryName"       = var.repository_name
      }
      input_artifacts = []
      name            = "Source"
      output_artifacts = [
        "SourceArtifact",
      ]
      owner     = "ThirdParty"
      provider  = "Github"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Deploy"

    action {
      category = "Deploy"
      configuration = {
        "BucketName" = "flaskapp"
        "Extract"    = "true"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name             = "Deploy"
      output_artifacts = []
      owner            = "AWS"
      provider         = "S3"
      run_order        = 1
      version          = "1"
    }
  }
}



resource "aws_codepipeline_webhook" "codepipeline_webhook" {
  authentication  = "GITHUB_HMAC"
  name            = "codepipeline-webhook"
  target_action   = "Source"
  target_pipeline = aws_codepipeline.flaskapp_pipeline.name

  authentication_configuration {
    secret_token = random_string.github_secret.result
  }

  filter {
    json_path    = "$.ref"
    match_equals = "refs/heads/{Branch}"
  }
  tags = {}
}

resource "github_repository_webhook" "github_hook" {
  repository = var.repository_name
  events     = ["push"]

  configuration {
    url          = aws_codepipeline_webhook.codepipeline_webhook.url
    insecure_ssl = "0"
    content_type = "json"
    secret       = random_string.github_secret.result
  }
}

resource "random_string" "github_secret" {
  length  = 99
  special = false
}